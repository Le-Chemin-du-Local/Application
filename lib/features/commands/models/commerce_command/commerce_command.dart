import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'commerce_command.freezed.dart';
part 'commerce_command.g.dart';

@freezed
@immutable
class CommerceCommand with _$CommerceCommand {
  const factory CommerceCommand(String? id, {
    required String status,
    DateTime? pickupDate,
    Commerce? commerce,
    User? user,
  }) = _CommerceCommand;

  factory CommerceCommand.fromJson(Map<String, dynamic> json) => _$CommerceCommandFromJson(json);
}