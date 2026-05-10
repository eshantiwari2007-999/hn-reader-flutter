import 'package:dio/dio.dart';
import 'package:hn_reader/core/errors/exceptions.dart';

/// Converts a [DioException] into the appropriate domain [Exception] subtype.
///
/// Call this inside every data-source `catch` block to keep error handling
/// consistent across the entire data layer.
///
/// Example:
/// ```dart
/// try {
///   final response = await dio.get('/topstories.json');
///   return response.data;
/// } on DioException catch (e) {
///   throw mapDioException(e);
/// }
/// ```
Exception mapDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return TimeoutException(message: AppConstants_network.timeoutError);

    case DioExceptionType.connectionError:
      return NetworkException(message: AppConstants_network.networkError);

    case DioExceptionType.badResponse:
      return ServerException(
        message: e.response?.statusMessage ?? 'Server error',
        statusCode: e.response?.statusCode,
      );

    case DioExceptionType.cancel:
      return ServerException(message: 'Request was cancelled.');

    case DioExceptionType.badCertificate:
      return ServerException(message: 'Bad server certificate.');

    case DioExceptionType.unknown:
    default:
      return ServerException(message: e.message ?? 'An unknown error occurred.');
  }
}

// Internal constant aliases used only inside this file to avoid a circular
// import with AppConstants (which lives in core/constants).
class AppConstants_network {
  AppConstants_network._();
  static const String networkError = 'No internet connection.';
  static const String timeoutError = 'The request timed out.';
}
