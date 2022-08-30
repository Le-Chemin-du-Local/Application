import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transfert.freezed.dart';
part 'transfert.g.dart';

@freezed
@immutable
class Transfert with _$Transfert {
  const factory Transfert({
    required double value,
    required String ibanOwner,
    required String iban,
    required String bic
  }) = _Transfert;

  factory Transfert.fromJson(Map<String, dynamic> json) => _$TransfertFromJson(json);
}