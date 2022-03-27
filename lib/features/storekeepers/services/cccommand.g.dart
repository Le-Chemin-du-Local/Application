// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cccommand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CCCommand _$$_CCCommandFromJson(Map<String, dynamic> json) => _$_CCCommand(
      json['id'] as String?,
      status: json['status'] as String,
      pickupDate: DateTime.parse(json['pickupDate'] as String),
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => CCProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CCProduct>[],
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CCCommandToJson(_$_CCCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'pickupDate': instance.pickupDate.toIso8601String(),
      'products': instance.products,
      'user': instance.user,
    };
