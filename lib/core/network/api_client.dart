import 'package:dio/dio.dart';
import 'package:hn_reader/core/constants/constants.dart';

/// Configured [Dio] HTTP client for the Hacker News Firebase REST API.
///
/// Singleton pattern via factory constructor – a single instance is used
/// throughout the application and injected via Riverpod providers.
class ApiClient {
  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    )
      // Logging interceptor (only in debug builds)
      ..interceptors.addAll([
        _buildLogInterceptor(),
        _buildRetryInterceptor(),
      ]);
  }

  static final ApiClient _instance = ApiClient._internal();

  /// Factory constructor returns the singleton instance.
  factory ApiClient() => _instance;

  late final Dio _dio;

  /// Exposes the underlying [Dio] instance for direct use in data sources.
  Dio get dio => _dio;

  // ---------------------------------------------------------------------------
  // Interceptors
  // ---------------------------------------------------------------------------

  /// Pretty-prints requests and responses in debug mode.
  LogInterceptor _buildLogInterceptor() {
    return LogInterceptor(
      request: true,
      requestHeader: false,
      requestBody: false,
      responseHeader: false,
      responseBody: true,
      error: true,
    );
  }

  /// Simple retry interceptor – retries once on connection errors.
  InterceptorsWrapper _buildRetryInterceptor() {
    return InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        if (_isRetriable(error) && error.requestOptions.extra['retried'] != true) {
          error.requestOptions.extra['retried'] = true;
          try {
            final response = await _dio.fetch(error.requestOptions);
            handler.resolve(response);
            return;
          } catch (_) {
            // Fall through to the original error handler.
          }
        }
        handler.next(error);
      },
    );
  }

  /// Returns true if the [DioException] type warrants a retry.
  bool _isRetriable(DioException error) {
    return error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError;
  }
}
