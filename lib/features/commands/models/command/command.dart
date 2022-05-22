import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'command.freezed.dart';
part 'command.g.dart';

@freezed
@immutable
class Command with _$Command {
  const factory Command(String? id, {
    DateTime? creationDate, 
    User? user,
    @Default(<CommerceCommand>[]) List<CommerceCommand> commerces,
    String? status,
  }) = _Command;

  factory Command.fromJson(Map<String, dynamic> json) => _$CommandFromJson(json);
}