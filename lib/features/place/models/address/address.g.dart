// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Address _$$_AddressFromJson(Map<String, dynamic> json) => _$_Address(
      number: json['number'] as String?,
      route: json['route'] as String?,
      optionalRoute: json['optionalRoute'] as String?,
      postalCode: json['postalCode'] as String?,
      city: json['city'] as String?,
    );

Map<String, dynamic> _$$_AddressToJson(_$_Address instance) =>
    <String, dynamic>{
      'number': instance.number,
      'route': instance.route,
      'optionalRoute': instance.optionalRoute,
      'postalCode': instance.postalCode,
      'city': instance.city,
    };
