import 'package:chemin_du_local/features/storekeepers/services/paniers/models/panier/panier.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'panier_command.freezed.dart';
part 'panier_command.g.dart';

mixin PanierCommandStatus {
  static const String inProgress = "INPROGRESS";
  static const String ready = "READY"; 
  static const String done = "DONE";
}

@freezed
@immutable
class PanierCommand with _$PanierCommand {
  const factory PanierCommand(String? id, {
    required Panier panier,
  }) = _PanierCommand;

  factory PanierCommand.fromJson(Map<String, dynamic> json) => _$PanierCommandFromJson(json);
}