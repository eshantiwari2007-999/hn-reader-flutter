import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

/// Sealed union of domain-layer failures.
///
/// Repositories return `Either<Failure, T>` (or throw) so the presentation
/// layer can pattern-match on failure type rather than catching raw exceptions.
///
/// Using [Freezed] gives us:
///  - Immutability
///  - Structural equality (== / hashCode)
///  - `when` / `map` / `maybeWhen` helpers for exhaustive matching
@freezed
class Failure with _$Failure {
  /// Generic server-side failure (4xx, 5xx, network error).
  const factory Failure.server({
    @Default('Server error occurred.') String message,
    int? statusCode,
  }) = ServerFailure;

  /// No internet / connectivity failure.
  const factory Failure.network({
    @Default('No internet connection.') String message,
  }) = NetworkFailure;

  /// Request timed out.
  const factory Failure.timeout({
    @Default('The request timed out.') String message,
  }) = TimeoutFailure;

  /// Data parsing / serialization failure.
  const factory Failure.parse({
    @Default('Failed to parse data.') String message,
  }) = ParseFailure;

  /// Unknown / unexpected failure.
  const factory Failure.unknown({
    @Default('An unexpected error occurred.') String message,
  }) = UnknownFailure;
}

// =============================================================================
// Extensions
// =============================================================================

/// Provides a unified [message] getter across all [Failure] subtypes.
extension FailureX on Failure {
  String get message => when(
        server: (msg, _) => msg,
        network: (msg) => msg,
        timeout: (msg) => msg,
        parse: (msg) => msg,
        unknown: (msg) => msg,
      );
}
