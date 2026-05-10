// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryModelImpl _$$StoryModelImplFromJson(Map<String, dynamic> json) =>
    _$StoryModelImpl(
      id: (json['id'] as num).toInt(),
      by: json['by'] as String? ?? '[deleted]',
      time: (json['time'] as num?)?.toInt() ?? 0,
      type: _hnItemTypeFromJson(json['type'] as String?),
      title: json['title'] as String? ?? '',
      url: json['url'] as String?,
      text: json['text'] as String?,
      score: (json['score'] as num?)?.toInt() ?? 0,
      descendants: (json['descendants'] as num?)?.toInt() ?? 0,
      kids: (json['kids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      deleted: json['deleted'] as bool? ?? false,
      dead: json['dead'] as bool? ?? false,
    );

Map<String, dynamic> _$$StoryModelImplToJson(_$StoryModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'by': instance.by,
      'time': instance.time,
      'type': _hnItemTypeToJson(instance.type),
      'title': instance.title,
      'url': instance.url,
      'text': instance.text,
      'score': instance.score,
      'descendants': instance.descendants,
      'kids': instance.kids,
      'deleted': instance.deleted,
      'dead': instance.dead,
    };
