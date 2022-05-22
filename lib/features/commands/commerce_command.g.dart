// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commerce_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CommerceCommand _$$_CommerceCommandFromJson(Map<String, dynamic> json) =>
    _$_CommerceCommand(
      json['id'] as String?,
      status: json['status'] as String,
      pickupDate: json['pickupDate'] == null
          ? null
          : DateTime.parse(json['pickupDate'] as String),
      commerce: json['commerce'] == null
          ? null
          : Commerce.fromJson(json['commerce'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CommerceCommandToJson(_$_CommerceCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'pickupDate': instance.pickupDate?.toIso8601String(),
      'commerce': instance.commerce,
      'user': instance.user,
    };
