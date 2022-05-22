// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BasketProduct _$$_BasketProductFromJson(Map<String, dynamic> json) =>
    _$_BasketProduct(
      quantity: json['quantity'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BasketProductToJson(_$_BasketProduct instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'product': instance.product,
    };
