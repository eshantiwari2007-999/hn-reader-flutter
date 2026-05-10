// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hn_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HnItemModelImpl _$$HnItemModelImplFromJson(Map<String, dynamic> json) =>
    _$HnItemModelImpl(
      id: (json['id'] as num).toInt(),
      rawType: json['type'] as String?,
      by: json['by'] as String?,
      time: (json['time'] as num?)?.toInt(),
      title: json['title'] as String?,
      url: json['url'] as String?,
      text: json['text'] as String?,
      score: (json['score'] as num?)?.toInt(),
      descendants: (json['descendants'] as num?)?.toInt(),
      kids: (json['kids'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      parent: (json['parent'] as num?)?.toInt(),
      poll: (json['poll'] as num?)?.toInt(),
      parts: (json['parts'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      deleted: json['deleted'] as bool? ?? false,
      dead: json['dead'] as bool? ?? false,
    );

Map<String, dynamic> _$$HnItemModelImplToJson(_$HnItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.rawType,
      'by': instance.by,
      'time': instance.time,
      'title': instance.title,
      'url': instance.url,
      'text': instance.text,
      'score': instance.score,
      'descendants': instance.descendants,
      'kids': instance.kids,
      'parent': instance.parent,
      'poll': instance.poll,
      'parts': instance.parts,
      'deleted': instance.deleted,
      'dead': instance.dead,
    };
