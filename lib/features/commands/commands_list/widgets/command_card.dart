import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commands/commands_list/widgets/command_card_commerce.dart';
import 'package:chemin_du_local/features/commands/models/command/command.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommandCard extends StatelessWidget {
  const CommandCard({
    Key? key,
    required this.command
  }) : super(key: key);

  final Command command;

  @override
  Widget build(BuildContext context) {
    final String creationDateString = command.creationDate != null 
      ? DateFormat("dd/MM/yyyy").format(command.creationDate!)
      : "Date inconnue";

    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Le titre
          Text(
            "Commande du $creationDateString",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w500
            )
          ),
          const SizedBox(height: 18,),

          for (final commerce in command.commerces) ...{
            Text(
              commerce.commerce?.name ?? "Nom inconnue", 
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500
              ),

            ),
            const SizedBox(height: 4,),
            CommandCardCommerce(commerceCommand: commerce,)
          }
        ],
      ),
    );
  }
}