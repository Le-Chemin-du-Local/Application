import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/models/ccproduct/ccproduct.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cccommand.freezed.dart';
part 'cccommand.g.dart';

mixin CCCommandStatus {
  static const String inProgress = "INPROGRESS";
  static const String ready = "READY"; 
  static const String done = "DONE";
}

@freezed
@immutable
class CCCommand with _$CCCommand {
  const factory CCCommand(String? id, {
    @Default(<CCProduct>[]) List<CCProduct> products,
  }) = _CCCommand;

  factory CCCommand.fromJson(Map<String, dynamic> json) => _$CCCommandFromJson(json);
}