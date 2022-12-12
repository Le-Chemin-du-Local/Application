import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'command.freezed.dart';
part 'command.g.dart';

@freezed
@immutable
class Command with _$Command {
  const Command._();

  const factory Command(String? id, {
    DateTime? creationDate, 
    User? user,
    @Default(<CommerceCommand>[]) List<CommerceCommand> commerces,
    String? status,
  }) = _Command;

  factory Command.fromJson(Map<String, dynamic> json) => _$CommandFromJson(json);

  double get totalPrice {
    double result = 0;

    for (final commerceCommand in commerces) {
      // On commence avec les produits
      result += commerceCommand.price ?? 0;
    }

    return result;
  }


  int get totalCount {
    int result = 0;

    for (final commerceCommand in commerces) {
      // On commence avec les produits
      for (final cccommand in commerceCommand.cccommands) {
        for (final product in cccommand.products) {
          result += product.quantity;
        }
      }

      // Ensuite les paniers
      for (int i = 0; i < commerceCommand.panierCommands.length; ++i) {
        result += 1;
      }
    }

    return result;
  }
}