// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panier_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PanierProduct _$$_PanierProductFromJson(Map<String, dynamic> json) =>
    _$_PanierProduct(
      quantity: json['quantity'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PanierProductToJson(_$_PanierProduct instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'product': instance.product,
    };
