import 'package:dio/dio.dart';
import 'package:hn_reader/core/constants/constants.dart';
import 'package:hn_reader/core/errors/exceptions.dart';
import 'package:hn_reader/core/network/api_client.dart';
import 'package:hn_reader/data/models/hn_item_model.dart';

/// Remote data source for the Hacker News Firebase REST API.
///
/// ## Single model principle
/// All item requests go through [HnItemModel]. The data source does not
/// know whether an ID corresponds to a story or a comment – that distinction
/// is made by the repository after inspecting [HnItemModel.itemType].
///
/// ## Error handling
/// All [DioException]s are caught here and converted to domain exception types
/// ([ServerException], [NetworkException], [TimeoutException], [ParseException]).
/// The data source never leaks Dio-specific types upward.
///
/// ## Parallelism
/// The list-fetch helpers in the repositories use [Future.wait] to parallelise
/// individual item requests – this class deliberately does not batch requests
/// itself, keeping it focused on single-item concerns.
class HnRemoteDataSource {
  HnRemoteDataSource({required ApiClient apiClient})
      : _dio = apiClient.dio;

  final Dio _dio;

  // ---------------------------------------------------------------------------
  // Story ID lists  (return only numeric ID arrays)
  // ---------------------------------------------------------------------------

  /// Returns up to 500 current top-story IDs, ranked by HN's algorithm.
  Future<List<int>> getTopStoryIds() =>
      _fetchIds(AppConstants.topStoriesEndpoint);

  /// Returns up to 500 best-story IDs.
  Future<List<int>> getBestStoryIds() =>
      _fetchIds(AppConstants.bestStoriesEndpoint);

  /// Returns up to 500 newest story IDs (chronological).
  Future<List<int>> getNewStoryIds() =>
      _fetchIds(AppConstants.newStoriesEndpoint);

  /// Returns up to 200 Ask HN story IDs.
  Future<List<int>> getAskStoryIds() =>
      _fetchIds(AppConstants.askStoriesEndpoint);

  /// Returns up to 200 Show HN story IDs.
  Future<List<int>> getShowStoryIds() =>
      _fetchIds(AppConstants.showStoriesEndpoint);

  // ---------------------------------------------------------------------------
  // Single item fetch  (returns the unified HnItemModel)
  // ---------------------------------------------------------------------------

  /// Fetches **any** HN item (story, comment, job, poll) by [id].
  ///
  /// Returns an [HnItemModel] whose [HnItemModel.itemType] tells the
  /// repository how to map it to a domain entity.
  ///
  /// Throws:
  ///  - [ServerException]  – non-2xx HTTP response.
  ///  - [NetworkException] – no internet / DNS failure.
  ///  - [TimeoutException] – request exceeded the configured timeout.
  ///  - [ParseException]   – response was null or could not be deserialized.
  Future<HnItemModel> getItem(int id) async {
    try {
      final url = AppConstants.itemEndpoint.replaceFirst('{id}', '$id');
      final response = await _dio.get<Map<String, dynamic>>(url);

      if (response.data == null) {
        throw ParseException(
          message: 'Received null body for item id=$id.',
        );
      }

      return HnItemModel.fromJson(response.data!);
    } on DioException catch (e) {
      throw _mapDioException(e);
    } on ParseException {
      rethrow; // already a domain exception
    } catch (e) {
      throw ParseException(message: 'Unexpected error parsing item: $e');
    }
  }

  // ---------------------------------------------------------------------------
  // Private helpers
  // ---------------------------------------------------------------------------

  /// Fetches a list of integer IDs from an endpoint that returns `[1, 2, 3…]`.
  Future<List<int>> _fetchIds(String endpoint) async {
    try {
      final response = await _dio.get<List<dynamic>>(endpoint);

      if (response.data == null) return const [];

      // `cast<int>()` is safe here: the HN API always returns integer arrays.
      return response.data!.cast<int>();
    } on DioException catch (e) {
      throw _mapDioException(e);
    } catch (e) {
      throw ParseException(message: 'Failed to parse ID list from $endpoint: $e');
    }
  }

  /// Converts a [DioException] into the appropriate domain exception.
  ///
  /// Kept private to this class – the exception types are imported from
  /// `core/errors/exceptions.dart` and are Dio-agnostic.
  Exception _mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();

      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        return ServerException(
          message: e.response?.statusMessage ?? 'Server error',
          statusCode: e.response?.statusCode,
        );

      case DioExceptionType.cancel:
        return const ServerException(message: 'Request was cancelled.');

      case DioExceptionType.badCertificate:
        return const ServerException(message: 'Bad server certificate.');

      case DioExceptionType.unknown:
      default:
        return ServerException(
          message: e.message ?? 'An unknown network error occurred.',
        );
    }
  }
}
