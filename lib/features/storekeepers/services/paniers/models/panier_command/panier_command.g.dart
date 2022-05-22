// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panier_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PanierCommand _$$_PanierCommandFromJson(Map<String, dynamic> json) =>
    _$_PanierCommand(
      json['id'] as String?,
      status: json['status'] as String,
      pickupDate: DateTime.parse(json['pickupDate'] as String),
      panier: Panier.fromJson(json['panier'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PanierCommandToJson(_$_PanierCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'pickupDate': instance.pickupDate.toIso8601String(),
      'panier': instance.panier,
      'user': instance.user,
    };
