// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cl_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClFile _$$_ClFileFromJson(Map<String, dynamic> json) => _$_ClFile(
      filename: json['name'] as String,
      base64content: json['content'] as String?,
    );

Map<String, dynamic> _$$_ClFileToJson(_$_ClFile instance) => <String, dynamic>{
      'name': instance.filename,
      'content': instance.base64content,
    };
