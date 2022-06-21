// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panier_command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PanierCommand _$$_PanierCommandFromJson(Map<String, dynamic> json) =>
    _$_PanierCommand(
      json['id'] as String?,
      panier: Panier.fromJson(json['panier'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PanierCommandToJson(_$_PanierCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'panier': instance.panier,
    };
