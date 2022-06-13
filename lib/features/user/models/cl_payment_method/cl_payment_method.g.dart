// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cl_payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ClPaymentMethod _$$_ClPaymentMethodFromJson(Map<String, dynamic> json) =>
    _$_ClPaymentMethod(
      name: json['name'] as String?,
      stripeID: json['stripeID'] as String?,
      cardBrand: json['cardBrand'] as String?,
      cardLast4Digits: json['cardLast4Digits'] as String?,
    );

Map<String, dynamic> _$$_ClPaymentMethodToJson(_$_ClPaymentMethod instance) =>
    <String, dynamic>{
      'name': instance.name,
      'stripeID': instance.stripeID,
      'cardBrand': instance.cardBrand,
      'cardLast4Digits': instance.cardLast4Digits,
    };
