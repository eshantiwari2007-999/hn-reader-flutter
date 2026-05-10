import 'package:hn_reader/core/errors/exceptions.dart';
import 'package:hn_reader/core/errors/failures.dart';

/// Discriminated union: either [Ok] (success) or [Err] (domain failure).
///
/// Replaces raw exception throwing at the repository boundary so callers
/// can pattern-match exhaustively instead of wrapping in try/catch.
///
/// ## Usage
/// ```dart
/// final result = await repository.getTopStoryIds();
/// switch (result) {
///   case Ok(:final value): print('${value.length} IDs');
///   case Err(:final failure): print(failure.message);
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// Runs [fn] and wraps any domain exception into [Err].
  static Future<Result<T>> guardAsync<T>(Future<T> Function() fn) async {
    try {
      return Ok(await fn());
    } on ServerException catch (e) {
      return Err(Failure.server(message: e.message, statusCode: e.statusCode));
    } on NetworkException catch (e) {
      return Err(Failure.network(message: e.message));
    } on TimeoutException catch (e) {
      return Err(Failure.timeout(message: e.message));
    } on ParseException catch (e) {
      return Err(Failure.parse(message: e.message));
    } catch (e) {
      return Err(Failure.unknown(message: e.toString()));
    }
  }
}

/// Success variant – holds the result [value].
final class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;

  @override
  String toString() => 'Ok($value)';
}

/// Failure variant – holds a domain [Failure].
final class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;

  @override
  String toString() => 'Err(${failure.message})';
}

// =============================================================================
// Extensions
// =============================================================================

extension ResultX<T> on Result<T> {
  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;

  T? get valueOrNull => switch (this) {
        Ok(:final value) => value,
        Err() => null,
      };

  Failure? get failureOrNull => switch (this) {
        Err(:final failure) => failure,
        Ok() => null,
      };

  /// Exhaustive pattern matching.
  R when<R>({
    required R Function(T value) ok,
    required R Function(Failure failure) err,
  }) =>
      switch (this) {
        Ok(:final value) => ok(value),
        Err(:final failure) => err(failure),
      };

  /// Transforms the success value; propagates errors unchanged.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
        Ok(:final value) => Ok(transform(value)),
        Err(:final failure) => Err(failure),
      };

  /// Chains an async operation that itself returns [Result].
  /// Short-circuits with the current error if this is [Err].
  Future<Result<R>> flatMap<R>(
    Future<Result<R>> Function(T value) transform,
  ) =>
      switch (this) {
        Ok(:final value) => transform(value),
        Err(:final failure) => Future.value(Err<R>(failure)),
      };
}
