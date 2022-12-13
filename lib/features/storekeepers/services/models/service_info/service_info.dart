import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_info.freezed.dart';
part "service_info.g.dart";

enum ServiceType { monthly, transactions }

@immutable
@freezed
class ServiceInfo with _$ServiceInfo {
  const factory ServiceInfo(String id, {
    required String name,
    required String shortDescription,
    required String longDescription,
    required double monthPrice,
    required double monthMinimumAllowedCA,
    required double monthCARange,
    required double monthCAPriceAugmentation,
    required List<String> monthAdvantages,
    required double transactionPercentage,
    required List<String> transactionAdvantages,
  }) = _ServiceInfo;

  factory ServiceInfo.fromJson(Map<String, dynamic> json) => _$ServiceInfoFromJson(json);
} 