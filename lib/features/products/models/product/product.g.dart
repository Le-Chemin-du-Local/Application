// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Product _$$_ProductFromJson(Map<String, dynamic> json) => _$_Product(
      json['id'] as String?,
      name: json['name'] as String,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
      allergens: (json['allergens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      perUnitQuantity: (json['perUnitQuantity'] as num?)?.toDouble(),
      perUnitQuantityUnit: json['perUnitQuantityUnit'] as String?,
      tva: (json['tva'] as num?)?.toDouble(),
      isBreton: json['isBreton'] as bool?,
      hasGluten: json['hasGluten'] as bool?,
    );

Map<String, dynamic> _$$_ProductToJson(_$_Product instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categories': instance.categories,
      'tags': instance.tags,
      'allergens': instance.allergens,
      'description': instance.description,
      'price': instance.price,
      'unit': instance.unit,
      'perUnitQuantity': instance.perUnitQuantity,
      'perUnitQuantityUnit': instance.perUnitQuantityUnit,
      'tva': instance.tva,
      'isBreton': instance.isBreton,
      'hasGluten': instance.hasGluten,
    };
