// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commerce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Commerce _$$_CommerceFromJson(Map<String, dynamic> json) => _$_Commerce(
      json['id'] as String?,
      name: json['name'] as String,
      storekeeper: json['storekeeper'] == null
          ? null
          : User.fromJson(json['storekeeper'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      productsAvailableForClickAndCollect:
          (json['productsAvailableForClickAndCollect'] as List<dynamic>?)
                  ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              const <Product>[],
      storekeeperWord: json['storekeeperWord'] as String?,
      description: json['description'] as String?,
      address: json['addressDetailed'] == null
          ? null
          : Address.fromJson(json['addressDetailed'] as Map<String, dynamic>),
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
      businessHours: json['businessHours'] == null
          ? null
          : BusinessHours.fromJson(
              json['businessHours'] as Map<String, dynamic>),
      clickAndCollectHours: json['clickAndCollectHours'] == null
          ? null
          : BusinessHours.fromJson(
              json['clickAndCollectHours'] as Map<String, dynamic>),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_CommerceToJson(_$_Commerce instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'storekeeper': instance.storekeeper,
      'categories': instance.categories,
      'services': instance.services,
      'productsAvailableForClickAndCollect':
          instance.productsAvailableForClickAndCollect,
      'storekeeperWord': instance.storekeeperWord,
      'description': instance.description,
      'addressDetailed': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'businessHours': instance.businessHours,
      'clickAndCollectHours': instance.clickAndCollectHours,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
