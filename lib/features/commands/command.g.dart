// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Command _$$_CommandFromJson(Map<String, dynamic> json) => _$_Command(
      json['id'] as String?,
      creationDate: json['creationDate'] == null
          ? null
          : DateTime.parse(json['creationDate'] as String),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      commerces: (json['commerces'] as List<dynamic>?)
              ?.map((e) => CommerceCommand.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CommerceCommand>[],
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$_CommandToJson(_$_Command instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creationDate': instance.creationDate?.toIso8601String(),
      'user': instance.user,
      'commerces': instance.commerces,
      'status': instance.status,
    };
