// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return _CommentModel.fromJson(json);
}

/// @nodoc
mixin _$CommentModel {
  int get id => throw _privateConstructorUsedError;
  String get by => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;
  int? get parent => throw _privateConstructorUsedError;
  List<int> get kids => throw _privateConstructorUsedError;
  bool get deleted => throw _privateConstructorUsedError;
  bool get dead => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentModelCopyWith<CommentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentModelCopyWith<$Res> {
  factory $CommentModelCopyWith(
          CommentModel value, $Res Function(CommentModel) then) =
      _$CommentModelCopyWithImpl<$Res, CommentModel>;
  @useResult
  $Res call({
    int id,
    String by,
    String text,
    int time,
    int? parent,
    List<int> kids,
    bool deleted,
    bool dead,
  });
}

/// @nodoc
class _$CommentModelCopyWithImpl<$Res, $Val extends CommentModel>
    implements $CommentModelCopyWith<$Res> {
  _$CommentModelCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? by = null,
    Object? text = null,
    Object? time = null,
    Object? parent = freezed,
    Object? kids = null,
    Object? deleted = null,
    Object? dead = null,
  }) {
    return _then(_value.copyWith(
      id: null == id ? _value.id : id as int,
      by: null == by ? _value.by : by as String,
      text: null == text ? _value.text : text as String,
      time: null == time ? _value.time : time as int,
      parent: freezed == parent ? _value.parent : parent as int?,
      kids: null == kids ? _value.kids : kids as List<int>,
      deleted: null == deleted ? _value.deleted : deleted as bool,
      dead: null == dead ? _value.dead : dead as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentModelImplCopyWith<$Res>
    implements $CommentModelCopyWith<$Res> {
  factory _$$CommentModelImplCopyWith(
          _$CommentModelImpl value, $Res Function(_$CommentModelImpl) then) =
      __$$CommentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String by,
    String text,
    int time,
    int? parent,
    List<int> kids,
    bool deleted,
    bool dead,
  });
}

/// @nodoc
class __$$CommentModelImplCopyWithImpl<$Res>
    extends _$CommentModelCopyWithImpl<$Res, _$CommentModelImpl>
    implements _$$CommentModelImplCopyWith<$Res> {
  __$$CommentModelImplCopyWithImpl(
      _$CommentModelImpl _value, $Res Function(_$CommentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? by = null,
    Object? text = null,
    Object? time = null,
    Object? parent = freezed,
    Object? kids = null,
    Object? deleted = null,
    Object? dead = null,
  }) {
    return _then(_$CommentModelImpl(
      id: null == id ? _value.id : id as int,
      by: null == by ? _value.by : by as String,
      text: null == text ? _value.text : text as String,
      time: null == time ? _value.time : time as int,
      parent: freezed == parent ? _value.parent : parent as int?,
      kids: null == kids ? _value._kids : kids as List<int>,
      deleted: null == deleted ? _value.deleted : deleted as bool,
      dead: null == dead ? _value.dead : dead as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentModelImpl implements _CommentModel {
  const _$CommentModelImpl({
    required this.id,
    this.by = '[deleted]',
    this.text = '',
    required this.time,
    this.parent,
    final List<int> kids = const [],
    this.deleted = false,
    this.dead = false,
  }) : _kids = kids;

  factory _$CommentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String by;
  @override
  @JsonKey()
  final String text;
  @override
  final int time;
  @override
  final int? parent;
  final List<int> _kids;
  @override
  @JsonKey()
  List<int> get kids {
    if (_kids is EqualUnmodifiableListView) return _kids;
    return EqualUnmodifiableListView(_kids);
  }

  @override
  @JsonKey()
  final bool deleted;
  @override
  @JsonKey()
  final bool dead;

  @override
  String toString() {
    return 'CommentModel(id: $id, by: $by, text: $text, time: $time, parent: $parent, kids: $kids, deleted: $deleted, dead: $dead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.by, by) || other.by == by) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.parent, parent) || other.parent == parent) &&
            const DeepCollectionEquality().equals(other._kids, _kids) &&
            (identical(other.deleted, deleted) || other.deleted == deleted) &&
            (identical(other.dead, dead) || other.dead == dead));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      by,
      text,
      time,
      parent,
      const DeepCollectionEquality().hash(_kids),
      deleted,
      dead);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      __$$CommentModelImplCopyWithImpl<_$CommentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentModelImplToJson(this);
  }
}

abstract class _CommentModel implements CommentModel {
  const factory _CommentModel({
    required final int id,
    final String by,
    final String text,
    required final int time,
    final int? parent,
    final List<int> kids,
    final bool deleted,
    final bool dead,
  }) = _$CommentModelImpl;

  factory _CommentModel.fromJson(Map<String, dynamic> json) =
      _$CommentModelImpl.fromJson;

  @override
  int get id;
  @override
  String get by;
  @override
  String get text;
  @override
  int get time;
  @override
  int? get parent;
  @override
  List<int> get kids;
  @override
  bool get deleted;
  @override
  bool get dead;
  @override
  @JsonKey(ignore: true)
  _$$CommentModelImplCopyWith<_$CommentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
