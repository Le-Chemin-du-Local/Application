import 'package:chemin_du_local/features/commerces/models/schedule/schedule.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_hours.freezed.dart';
part 'business_hours.g.dart';

@immutable
@Freezed(makeCollectionsUnmodifiable: false)
class BusinessHours with _$BusinessHours {
  const BusinessHours._();

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

  bool get isEmpty {
    if ((monday ?? []).isNotEmpty) return false;
    if ((tuesday ?? []).isNotEmpty) return false;
    if ((wednesday ?? []).isNotEmpty) return false;
    if ((thursday ?? []).isNotEmpty) return false;
    if ((friday ?? []).isNotEmpty) return false;
    if ((saturday ?? []).isNotEmpty) return false;
    if ((sunday ?? []).isNotEmpty) return false;

    return true;
  }

  bool isOpen(int dayIndex) {
    if (dayIndex == DateTime.monday && (monday ?? []).isNotEmpty) return true;
    if (dayIndex == DateTime.tuesday && (tuesday ?? []).isNotEmpty) return true;
    if (dayIndex == DateTime.wednesday && (wednesday ?? []).isNotEmpty) return true;
    if (dayIndex == DateTime.thursday && (thursday ?? []).isNotEmpty) return true;
    if (dayIndex == DateTime.friday && (friday ?? []).isNotEmpty) return true;
    if (dayIndex == DateTime.saturday && (saturday ?? []).isNotEmpty) return true;
    if (dayIndex == DateTime.sunday && (sunday ?? []).isNotEmpty) return true;

    return false;
  }
}