// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ccproduct.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CCProduct _$$_CCProductFromJson(Map<String, dynamic> json) => _$_CCProduct(
      quantity: json['quantity'] as int,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CCProductToJson(_$_CCProduct instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'product': instance.product,
    };
