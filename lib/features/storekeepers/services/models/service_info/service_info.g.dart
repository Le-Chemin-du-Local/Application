// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ServiceInfo _$$_ServiceInfoFromJson(Map<String, dynamic> json) =>
    _$_ServiceInfo(
      json['id'] as String,
      name: json['name'] as String,
      shortDescription: json['shortDescription'] as String,
      longDescription: json['longDescription'] as String,
      monthPrice: (json['monthPrice'] as num).toDouble(),
      monthMinimumAllowedCA: (json['monthMinimumAllowedCA'] as num).toDouble(),
      monthCARange: (json['monthCARange'] as num).toDouble(),
      monthCAPriceAugmentation:
          (json['monthCAPriceAugmentation'] as num).toDouble(),
      monthAdvantages: (json['monthAdvantages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      transactionPercentage: (json['transactionPercentage'] as num).toDouble(),
      transactionAdvantages: (json['transactionAdvantages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ServiceInfoToJson(_$_ServiceInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'longDescription': instance.longDescription,
      'monthPrice': instance.monthPrice,
      'monthMinimumAllowedCA': instance.monthMinimumAllowedCA,
      'monthCARange': instance.monthCARange,
      'monthCAPriceAugmentation': instance.monthCAPriceAugmentation,
      'monthAdvantages': instance.monthAdvantages,
      'transactionPercentage': instance.transactionPercentage,
      'transactionAdvantages': instance.transactionAdvantages,
    };
