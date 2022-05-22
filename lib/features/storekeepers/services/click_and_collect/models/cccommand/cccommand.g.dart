// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cccommand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CCCommand _$$_CCCommandFromJson(Map<String, dynamic> json) => _$_CCCommand(
      json['id'] as String?,
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => CCProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <CCProduct>[],
    );

Map<String, dynamic> _$$_CCCommandToJson(_$_CCCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'products': instance.products,
    };
