// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_hours.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusinessHours _$$_BusinessHoursFromJson(Map<String, dynamic> json) =>
    _$_BusinessHours(
      monday: (json['monday'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      tuesday: (json['tuesday'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      wednesday: (json['wednesday'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      thursday: (json['thursday'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      friday: (json['friday'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      saturday: (json['saturday'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      sunday: (json['sunday'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_BusinessHoursToJson(_$_BusinessHours instance) =>
    <String, dynamic>{
      'monday': instance.monday,
      'tuesday': instance.tuesday,
      'wednesday': instance.wednesday,
      'thursday': instance.thursday,
      'friday': instance.friday,
      'saturday': instance.saturday,
      'sunday': instance.sunday,
    };
