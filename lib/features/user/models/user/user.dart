import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/user/models/cl_payment_method/cl_payment_method.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

mixin UserRoles {
  static const String admin = "ADMIN";
  static const String storeKeeper = "STOREKEEPER";
  static const String client = "CLIENT";
}

@freezed
@immutable
class User with _$User {
  const factory User(String? id, {
    required String role,
    required String email,
    String? firstName,
    String? lastName,
    DateTime? createdAt,
    Commerce? commerce,
    @Default(<ClPaymentMethod>[]) List<ClPaymentMethod> registeredPaymentMethods,
    ClPaymentMethod? defaultPaymentMethod,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}