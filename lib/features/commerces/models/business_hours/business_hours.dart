import 'package:chemin_du_local/features/commerces/models/schedule/schedule.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_hours.freezed.dart';
part 'business_hours.g.dart';

@immutable
@freezed
class BusinessHours with _$BusinessHours {
  const factory BusinessHours({
    List<Schedule>? monday,
    List<Schedule>? tuesday,
    List<Schedule>? wednesday,
    List<Schedule>? thursday,
    List<Schedule>? friday,
    List<Schedule>? saturday,
    List<Schedule>? sunday,
  }) = _BusinessHours;

  factory BusinessHours.fromJson(Map<String, dynamic> json) => _$BusinessHoursFromJson(json);
}