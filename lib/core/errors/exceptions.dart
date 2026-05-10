/// Domain-layer exception types.
///
/// These are thrown by data-source implementations and caught by the
/// repository, which converts them into [Failure] objects for the
/// presentation layer to consume.

/// Thrown when a network / HTTP request fails.
class ServerException implements Exception {
  const ServerException({
    this.message = 'An unexpected server error occurred.',
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      'ServerException(statusCode: $statusCode, message: $message)';
}

/// Thrown when the device has no internet connectivity.
class NetworkException implements Exception {
  const NetworkException({
    this.message = 'No internet connection.',
  });

  final String message;

  @override
  String toString() => 'NetworkException(message: $message)';
}

/// Thrown when a request exceeds the configured timeout.
class TimeoutException implements Exception {
  const TimeoutException({
    this.message = 'The request timed out.',
  });

  final String message;

  @override
  String toString() => 'TimeoutException(message: $message)';
}

/// Thrown when JSON parsing / deserialization fails.
class ParseException implements Exception {
  const ParseException({
    this.message = 'Failed to parse response data.',
  });

  final String message;

  @override
  String toString() => 'ParseException(message: $message)';
}
