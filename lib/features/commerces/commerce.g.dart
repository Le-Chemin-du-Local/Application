// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commerce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Commerce _$$_CommerceFromJson(Map<String, dynamic> json) => _$_Commerce(
      json['id'] as String?,
      name: json['name'] as String,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      storekeeperWord: json['storekeeperWord'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
    );

Map<String, dynamic> _$$_CommerceToJson(_$_Commerce instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categories': instance.categories,
      'services': instance.services,
      'storekeeperWord': instance.storekeeperWord,
      'description': instance.description,
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
    };
