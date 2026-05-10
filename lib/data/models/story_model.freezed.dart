// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) {
  return _StoryModel.fromJson(json);
}

/// @nodoc
mixin _$StoryModel {
  int get id => throw _privateConstructorUsedError;
  String get by => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;
  HnItemType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get descendants => throw _privateConstructorUsedError;
  List<int> get kids => throw _privateConstructorUsedError;
  bool get deleted => throw _privateConstructorUsedError;
  bool get dead => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryModelCopyWith<StoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryModelCopyWith<$Res> {
  factory $StoryModelCopyWith(
          StoryModel value, $Res Function(StoryModel) then) =
      _$StoryModelCopyWithImpl<$Res, StoryModel>;
  @useResult
  $Res call({
    int id,
    String by,
    int time,
    HnItemType type,
    String title,
    String? url,
    String? text,
    int score,
    int descendants,
    List<int> kids,
    bool deleted,
    bool dead,
  });
}

/// @nodoc
class _$StoryModelCopyWithImpl<$Res, $Val extends StoryModel>
    implements $StoryModelCopyWith<$Res> {
  _$StoryModelCopyWithImpl(this._value, this._then);
  final $Val _value;
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? by = null,
    Object? time = null,
    Object? type = null,
    Object? title = null,
    Object? url = freezed,
    Object? text = freezed,
    Object? score = null,
    Object? descendants = null,
    Object? kids = null,
    Object? deleted = null,
    Object? dead = null,
  }) {
    return _then(_value.copyWith(
      id: null == id ? _value.id : id as int,
      by: null == by ? _value.by : by as String,
      time: null == time ? _value.time : time as int,
      type: null == type ? _value.type : type as HnItemType,
      title: null == title ? _value.title : title as String,
      url: freezed == url ? _value.url : url as String?,
      text: freezed == text ? _value.text : text as String?,
      score: null == score ? _value.score : score as int,
      descendants: null == descendants ? _value.descendants : descendants as int,
      kids: null == kids ? _value.kids : kids as List<int>,
      deleted: null == deleted ? _value.deleted : deleted as bool,
      dead: null == dead ? _value.dead : dead as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StoryModelImplCopyWith<$Res>
    implements $StoryModelCopyWith<$Res> {
  factory _$$StoryModelImplCopyWith(
          _$StoryModelImpl value, $Res Function(_$StoryModelImpl) then) =
      __$$StoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String by,
    int time,
    HnItemType type,
    String title,
    String? url,
    String? text,
    int score,
    int descendants,
    List<int> kids,
    bool deleted,
    bool dead,
  });
}

/// @nodoc
class __$$StoryModelImplCopyWithImpl<$Res>
    extends _$StoryModelCopyWithImpl<$Res, _$StoryModelImpl>
    implements _$$StoryModelImplCopyWith<$Res> {
  __$$StoryModelImplCopyWithImpl(
      _$StoryModelImpl _value, $Res Function(_$StoryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? by = null,
    Object? time = null,
    Object? type = null,
    Object? title = null,
    Object? url = freezed,
    Object? text = freezed,
    Object? score = null,
    Object? descendants = null,
    Object? kids = null,
    Object? deleted = null,
    Object? dead = null,
  }) {
    return _then(_$StoryModelImpl(
      id: null == id ? _value.id : id as int,
      by: null == by ? _value.by : by as String,
      time: null == time ? _value.time : time as int,
      type: null == type ? _value.type : type as HnItemType,
      title: null == title ? _value.title : title as String,
      url: freezed == url ? _value.url : url as String?,
      text: freezed == text ? _value.text : text as String?,
      score: null == score ? _value.score : score as int,
      descendants: null == descendants ? _value.descendants : descendants as int,
      kids: null == kids ? _value._kids : kids as List<int>,
      deleted: null == deleted ? _value.deleted : deleted as bool,
      dead: null == dead ? _value.dead : dead as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryModelImpl implements _StoryModel {
  const _$StoryModelImpl({
    required this.id,
    this.by = '[deleted]',
    this.time = 0,
    @JsonKey(name: 'type', fromJson: _hnItemTypeFromJson, toJson: _hnItemTypeToJson)
    this.type = HnItemType.story,
    this.title = '',
    this.url,
    this.text,
    this.score = 0,
    this.descendants = 0,
    final List<int> kids = const [],
    this.deleted = false,
    this.dead = false,
  }) : _kids = kids;

  factory _$StoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String by;
  @override
  @JsonKey()
  final int time;
  @override
  @JsonKey(name: 'type', fromJson: _hnItemTypeFromJson, toJson: _hnItemTypeToJson)
  final HnItemType type;
  @override
  @JsonKey()
  final String title;
  @override
  final String? url;
  @override
  final String? text;
  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int descendants;
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
    return 'StoryModel(id: $id, by: $by, time: $time, type: $type, title: $title, url: $url, text: $text, score: $score, descendants: $descendants, kids: $kids, deleted: $deleted, dead: $dead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.by, by) || other.by == by) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.descendants, descendants) || other.descendants == descendants) &&
            const DeepCollectionEquality().equals(other._kids, _kids) &&
            (identical(other.deleted, deleted) || other.deleted == deleted) &&
            (identical(other.dead, dead) || other.dead == dead));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, by, time, type, title, url, text, score, descendants,
      const DeepCollectionEquality().hash(_kids), deleted, dead);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryModelImplCopyWith<_$StoryModelImpl> get copyWith =>
      __$$StoryModelImplCopyWithImpl<_$StoryModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() => _$$StoryModelImplToJson(this);
}

abstract class _StoryModel implements StoryModel {
  const factory _StoryModel({
    required final int id,
    final String by,
    final int time,
    @JsonKey(name: 'type', fromJson: _hnItemTypeFromJson, toJson: _hnItemTypeToJson)
    final HnItemType type,
    final String title,
    final String? url,
    final String? text,
    final int score,
    final int descendants,
    final List<int> kids,
    final bool deleted,
    final bool dead,
  }) = _$StoryModelImpl;

  factory _StoryModel.fromJson(Map<String, dynamic> json) =
      _$StoryModelImpl.fromJson;

  @override
  int get id;
  @override
  String get by;
  @override
  int get time;
  @override
  HnItemType get type;
  @override
  String get title;
  @override
  String? get url;
  @override
  String? get text;
  @override
  int get score;
  @override
  int get descendants;
  @override
  List<int> get kids;
  @override
  bool get deleted;
  @override
  bool get dead;
  @override
  @JsonKey(ignore: true)
  _$$StoryModelImplCopyWith<_$StoryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
