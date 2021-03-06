// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      json['id'] as String?,
      role: json['role'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      commerce: json['commerce'] == null
          ? null
          : Commerce.fromJson(json['commerce'] as Map<String, dynamic>),
      registeredPaymentMethods: (json['registeredPaymentMethods']
                  as List<dynamic>?)
              ?.map((e) => ClPaymentMethod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ClPaymentMethod>[],
      defaultPaymentMethod: json['defaultPaymentMethod'] == null
          ? null
          : ClPaymentMethod.fromJson(
              json['defaultPaymentMethod'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'id': instance.id,
      'role': instance.role,
      'email': instance.email,
      'phone': instance.phone,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'createdAt': instance.createdAt?.toIso8601String(),
      'commerce': instance.commerce,
      'registeredPaymentMethods': instance.registeredPaymentMethods,
      'defaultPaymentMethod': instance.defaultPaymentMethod,
    };
