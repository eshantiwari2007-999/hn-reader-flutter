// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CommentEntity {
  int get id => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;
  String get by => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int? get parent => throw _privateConstructorUsedError;
  List<int> get kids => throw _privateConstructorUsedError;
  List<CommentEntity> get children => throw _privateConstructorUsedError;
  int get depth => throw _privateConstructorUsedError;
  bool get deleted => throw _privateConstructorUsedError;
  bool get dead => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentEntityCopyWith<CommentEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentEntityCopyWith<$Res> {
  factory $CommentEntityCopyWith(
          CommentEntity value, $Res Function(CommentEntity) then) =
      _$CommentEntityCopyWithImpl<$Res, CommentEntity>;
  @useResult
  $Res call({
    int id,
    int time,
    String by,
    String text,
    int? parent,
    List<int> kids,
    List<CommentEntity> children,
    int depth,
    bool deleted,
    bool dead,
  });
}

/// @nodoc
class _$CommentEntityCopyWithImpl<$Res, $Val extends CommentEntity>
    implements $CommentEntityCopyWith<$Res> {
  _$CommentEntityCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? time = null,
    Object? by = null,
    Object? text = null,
    Object? parent = freezed,
    Object? kids = null,
    Object? children = null,
    Object? depth = null,
    Object? deleted = null,
    Object? dead = null,
  }) {
    return _then(_value.copyWith(
      id: null == id ? _value.id : id as int,
      time: null == time ? _value.time : time as int,
      by: null == by ? _value.by : by as String,
      text: null == text ? _value.text : text as String,
      parent: freezed == parent ? _value.parent : parent as int?,
      kids: null == kids ? _value.kids : kids as List<int>,
      children: null == children ? _value.children : children as List<CommentEntity>,
      depth: null == depth ? _value.depth : depth as int,
      deleted: null == deleted ? _value.deleted : deleted as bool,
      dead: null == dead ? _value.dead : dead as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentEntityImplCopyWith<$Res>
    implements $CommentEntityCopyWith<$Res> {
  factory _$$CommentEntityImplCopyWith(
          _$CommentEntityImpl value, $Res Function(_$CommentEntityImpl) then) =
      __$$CommentEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int time,
    String by,
    String text,
    int? parent,
    List<int> kids,
    List<CommentEntity> children,
    int depth,
    bool deleted,
    bool dead,
  });
}

/// @nodoc
class __$$CommentEntityImplCopyWithImpl<$Res>
    extends _$CommentEntityCopyWithImpl<$Res, _$CommentEntityImpl>
    implements _$$CommentEntityImplCopyWith<$Res> {
  __$$CommentEntityImplCopyWithImpl(
      _$CommentEntityImpl _value, $Res Function(_$CommentEntityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? time = null,
    Object? by = null,
    Object? text = null,
    Object? parent = freezed,
    Object? kids = null,
    Object? children = null,
    Object? depth = null,
    Object? deleted = null,
    Object? dead = null,
  }) {
    return _then(_$CommentEntityImpl(
      id: null == id ? _value.id : id as int,
      time: null == time ? _value.time : time as int,
      by: null == by ? _value.by : by as String,
      text: null == text ? _value.text : text as String,
      parent: freezed == parent ? _value.parent : parent as int?,
      kids: null == kids ? _value._kids : kids as List<int>,
      children: null == children ? _value._children : children as List<CommentEntity>,
      depth: null == depth ? _value.depth : depth as int,
      deleted: null == deleted ? _value.deleted : deleted as bool,
      dead: null == dead ? _value.dead : dead as bool,
    ));
  }
}

/// @nodoc
class _$CommentEntityImpl extends _CommentEntity {
  const _$CommentEntityImpl({
    required this.id,
    required this.time,
    this.by = '[deleted]',
    this.text = '',
    this.parent,
    final List<int> kids = const [],
    final List<CommentEntity> children = const [],
    this.depth = 0,
    this.deleted = false,
    this.dead = false,
  })  : _kids = kids,
        _children = children,
        super._();

  @override
  final int id;
  @override
  final int time;
  @override
  @JsonKey()
  final String by;
  @override
  @JsonKey()
  final String text;
  @override
  final int? parent;
  final List<int> _kids;
  @override
  @JsonKey()
  List<int> get kids {
    if (_kids is EqualUnmodifiableListView) return _kids;
    return EqualUnmodifiableListView(_kids);
  }
  final List<CommentEntity> _children;
  @override
  @JsonKey()
  List<CommentEntity> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    return EqualUnmodifiableListView(_children);
  }
  @override
  @JsonKey()
  final int depth;
  @override
  @JsonKey()
  final bool deleted;
  @override
  @JsonKey()
  final bool dead;

  @override
  String toString() {
    return 'CommentEntity(id: $id, time: $time, by: $by, text: $text, parent: $parent, kids: $kids, children: $children, depth: $depth, deleted: $deleted, dead: $dead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.by, by) || other.by == by) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.parent, parent) || other.parent == parent) &&
            const DeepCollectionEquality().equals(other._kids, _kids) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.depth, depth) || other.depth == depth) &&
            (identical(other.deleted, deleted) || other.deleted == deleted) &&
            (identical(other.dead, dead) || other.dead == dead));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, time, by, text, parent,
      const DeepCollectionEquality().hash(_kids),
      const DeepCollectionEquality().hash(_children),
      depth, deleted, dead);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentEntityImplCopyWith<_$CommentEntityImpl> get copyWith =>
      __$$CommentEntityImplCopyWithImpl<_$CommentEntityImpl>(this, _$identity);
}

abstract class _CommentEntity extends CommentEntity {
  const factory _CommentEntity({
    required final int id,
    required final int time,
    final String by,
    final String text,
    final int? parent,
    final List<int> kids,
    final List<CommentEntity> children,
    final int depth,
    final bool deleted,
    final bool dead,
  }) = _$CommentEntityImpl;
  const _CommentEntity._() : super._();

  @override
  int get id;
  @override
  int get time;
  @override
  String get by;
  @override
  String get text;
  @override
  int? get parent;
  @override
  List<int> get kids;
  @override
  List<CommentEntity> get children;
  @override
  int get depth;
  @override
  bool get deleted;
  @override
  bool get dead;
  @override
  @JsonKey(ignore: true)
  _$$CommentEntityImplCopyWith<_$CommentEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
