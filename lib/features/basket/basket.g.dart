// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Basket _$$_BasketFromJson(Map<String, dynamic> json) => _$_Basket(
      commerces: (json['commerces'] as List<dynamic>?)
              ?.map((e) => BasketCommerce.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <BasketCommerce>[],
    );

Map<String, dynamic> _$$_BasketToJson(_$_Basket instance) => <String, dynamic>{
      'commerces': instance.commerces,
    };
