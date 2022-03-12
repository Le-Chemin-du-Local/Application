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
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}