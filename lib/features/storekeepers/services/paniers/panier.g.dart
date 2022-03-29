// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PanierProduct _$$_PanierProductFromJson(Map<String, dynamic> json) =>
    _$_PanierProduct(
      json['id'] as String?,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String? ?? "",
      quantity: json['quantity'] as int? ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => PanierProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PanierProduct>[],
      endingDate: json['endingDate'] == null
          ? null
          : DateTime.parse(json['endingDate'] as String),
    );

Map<String, dynamic> _$$_PanierProductToJson(_$_PanierProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
      'quantity': instance.quantity,
      'price': instance.price,
      'products': instance.products,
      'endingDate': instance.endingDate?.toIso8601String(),
    };
