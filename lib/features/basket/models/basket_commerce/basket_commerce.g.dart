// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_commerce.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BasketCommerce _$$_BasketCommerceFromJson(Map<String, dynamic> json) =>
    _$_BasketCommerce(
      commerceID: json['commerceID'] as String,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => BasketProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BasketProduct>[],
      paniers: (json['paniers'] as List<dynamic>?)
              ?.map((e) => Panier.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Panier>[],
      pickupDate: json['pickupDate'] == null
          ? null
          : DateTime.parse(json['pickupDate'] as String),
    );

Map<String, dynamic> _$$_BasketCommerceToJson(_$_BasketCommerce instance) =>
    <String, dynamic>{
      'commerceID': instance.commerceID,
      'products': instance.products,
      'paniers': instance.paniers,
      'pickupDate': instance.pickupDate?.toIso8601String(),
    };
