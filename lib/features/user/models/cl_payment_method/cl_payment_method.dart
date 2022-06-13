import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cl_payment_method.freezed.dart';
part 'cl_payment_method.g.dart';

@freezed
@immutable
class ClPaymentMethod with _$ClPaymentMethod {
  const factory ClPaymentMethod({
    String? name,
    String? stripeID,
    String? cardBrand,
    String? cardLast4Digits
  }) = _ClPaymentMethod;

  factory ClPaymentMethod.fromJson(Map<String, dynamic> json) => _$ClPaymentMethodFromJson(json);
}