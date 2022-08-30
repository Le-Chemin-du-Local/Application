// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Transfert _$$_TransfertFromJson(Map<String, dynamic> json) => _$_Transfert(
      value: (json['value'] as num).toDouble(),
      ibanOwner: json['ibanOwner'] as String,
      iban: json['iban'] as String,
      bic: json['bic'] as String,
    );

Map<String, dynamic> _$$_TransfertToJson(_$_Transfert instance) =>
    <String, dynamic>{
      'value': instance.value,
      'ibanOwner': instance.ibanOwner,
      'iban': instance.iban,
      'bic': instance.bic,
    };
