// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentModelImpl _$$CommentModelImplFromJson(Map<String, dynamic> json) =>
    _$CommentModelImpl(
      id: (json['id'] as num).toInt(),
      by: json['by'] as String? ?? '[deleted]',
      text: json['text'] as String? ?? '',
      time: (json['time'] as num?)?.toInt() ?? 0,
      parent: (json['parent'] as num?)?.toInt(),
      kids: (json['kids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      deleted: json['deleted'] as bool? ?? false,
      dead: json['dead'] as bool? ?? false,
    );

Map<String, dynamic> _$$CommentModelImplToJson(_$CommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'by': instance.by,
      'text': instance.text,
      'time': instance.time,
      'parent': instance.parent,
      'kids': instance.kids,
      'deleted': instance.deleted,
      'dead': instance.dead,
    };
