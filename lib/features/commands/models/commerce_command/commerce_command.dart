import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'commerce_command.freezed.dart';
part 'commerce_command.g.dart';

mixin CommandStatus {
  static const String inProgress = "INPROGRESS";
  static const String ready = "READY";
  static const String done = "DONE";

  static const Map<String, String> detailed = {
    inProgress: "En cours",
    ready: "Prête",
    done: "Fini",
  };

  static const Map<String, IconData> icon = {
    inProgress: Icons.refresh,
    ready: Icons.check,
    done: Icons.check,
  };
}

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