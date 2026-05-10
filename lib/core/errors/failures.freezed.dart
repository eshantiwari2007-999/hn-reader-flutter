// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Failure {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode) server,
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) parse,
    required TResult Function(String message) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? parse,
    TResult? Function(String message)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? parse,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(ParseFailure value) parse,
    required TResult Function(UnknownFailure value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(ParseFailure value)? parse,
    TResult? Function(UnknownFailure value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(ParseFailure value)? parse,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  final $Val _value;
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
          _$ServerFailureImpl value, $Res Function(_$ServerFailureImpl) then) =
      __$$ServerFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message, int? statusCode});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
      _$ServerFailureImpl _value, $Res Function(_$ServerFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? statusCode = freezed}) {
    return _then(_$ServerFailureImpl(
      message: null == message ? _value.message : message as String,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode as int?,
    ));
  }
}

/// @nodoc
class _$ServerFailureImpl implements ServerFailure {
  const _$ServerFailureImpl(
      {this.message = 'Server error occurred.', this.statusCode});

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String message;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'Failure.server(message: $message, statusCode: $statusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode);

  @pragma('vm:prefer-inline')
  @override
  $Res Function(_$ServerFailureImpl) get _then =>
      throw _privateConstructorUsedError;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode) server,
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) parse,
    required TResult Function(String message) unknown,
  }) {
    return server(message, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? parse,
    TResult? Function(String message)? unknown,
  }) {
    return server?.call(message, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? parse,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message, statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(ParseFailure value) parse,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(ParseFailure value)? parse,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(ParseFailure value)? parse,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ServerFailure implements Failure {
  const factory ServerFailure(
      {final String message, final int? statusCode}) = _$ServerFailureImpl;

  String get message;
  int? get statusCode;
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(_$NetworkFailureImpl value,
          $Res Function(_$NetworkFailureImpl) then) =
      __$$NetworkFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
      _$NetworkFailureImpl _value, $Res Function(_$NetworkFailureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(_$NetworkFailureImpl(
      message: null == message ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$NetworkFailureImpl implements NetworkFailure {
  const _$NetworkFailureImpl({this.message = 'No internet connection.'});

  @override
  final String message;

  @override
  String toString() {
    return 'Failure.network(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode) server,
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) parse,
    required TResult Function(String message) unknown,
  }) {
    return network(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? parse,
    TResult? Function(String message)? unknown,
  }) {
    return network?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? parse,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(ParseFailure value) parse,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(ParseFailure value)? parse,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(ParseFailure value)? parse,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure implements Failure {
  const factory NetworkFailure({final String message}) = _$NetworkFailureImpl;
  String get message;
}

/// @nodoc
class _$TimeoutFailureImpl implements TimeoutFailure {
  const _$TimeoutFailureImpl({this.message = 'The request timed out.'});
  @override
  final String message;

  @override
  String toString() => 'Failure.timeout(message: $message)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType &&
          other is _$TimeoutFailureImpl &&
          (identical(other.message, message) || other.message == message));

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode) server,
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) parse,
    required TResult Function(String message) unknown,
  }) => timeout(message);

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? parse,
    TResult? Function(String message)? unknown,
  }) => timeout?.call(message);

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? parse,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) => timeout != null ? timeout(message) : orElse();

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(ParseFailure value) parse,
    required TResult Function(UnknownFailure value) unknown,
  }) => timeout(this);

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(ParseFailure value)? parse,
    TResult? Function(UnknownFailure value)? unknown,
  }) => timeout?.call(this);

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(ParseFailure value)? parse,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) => timeout != null ? timeout(this) : orElse();
}

abstract class TimeoutFailure implements Failure {
  const factory TimeoutFailure({final String message}) = _$TimeoutFailureImpl;
  String get message;
}

/// @nodoc
class _$ParseFailureImpl implements ParseFailure {
  const _$ParseFailureImpl({this.message = 'Failed to parse data.'});
  @override
  final String message;

  @override
  String toString() => 'Failure.parse(message: $message)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType &&
          other is _$ParseFailureImpl &&
          (identical(other.message, message) || other.message == message));

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode) server,
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) parse,
    required TResult Function(String message) unknown,
  }) => parse(message);

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? parse,
    TResult? Function(String message)? unknown,
  }) => parse?.call(message);

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? parse,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) => parse != null ? parse(message) : orElse();

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(ParseFailure value) parse,
    required TResult Function(UnknownFailure value) unknown,
  }) => parse(this);

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(ParseFailure value)? parse,
    TResult? Function(UnknownFailure value)? unknown,
  }) => parse?.call(this);

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(ParseFailure value)? parse,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) => parse != null ? parse(this) : orElse();
}

abstract class ParseFailure implements Failure {
  const factory ParseFailure({final String message}) = _$ParseFailureImpl;
  String get message;
}

/// @nodoc
class _$UnknownFailureImpl implements UnknownFailure {
  const _$UnknownFailureImpl(
      {this.message = 'An unexpected error occurred.'});
  @override
  final String message;

  @override
  String toString() => 'Failure.unknown(message: $message)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other.runtimeType == runtimeType &&
          other is _$UnknownFailureImpl &&
          (identical(other.message, message) || other.message == message));

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode) server,
    required TResult Function(String message) network,
    required TResult Function(String message) timeout,
    required TResult Function(String message) parse,
    required TResult Function(String message) unknown,
  }) => unknown(message);

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode)? server,
    TResult? Function(String message)? network,
    TResult? Function(String message)? timeout,
    TResult? Function(String message)? parse,
    TResult? Function(String message)? unknown,
  }) => unknown?.call(message);

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode)? server,
    TResult Function(String message)? network,
    TResult Function(String message)? timeout,
    TResult Function(String message)? parse,
    TResult Function(String message)? unknown,
    required TResult orElse(),
  }) => unknown != null ? unknown(message) : orElse();

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ServerFailure value) server,
    required TResult Function(NetworkFailure value) network,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(ParseFailure value) parse,
    required TResult Function(UnknownFailure value) unknown,
  }) => unknown(this);

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ServerFailure value)? server,
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(ParseFailure value)? parse,
    TResult? Function(UnknownFailure value)? unknown,
  }) => unknown?.call(this);

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ServerFailure value)? server,
    TResult Function(NetworkFailure value)? network,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(ParseFailure value)? parse,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) => unknown != null ? unknown(this) : orElse();
}

abstract class UnknownFailure implements Failure {
  const factory UnknownFailure({final String message}) = _$UnknownFailureImpl;
  String get message;
}
