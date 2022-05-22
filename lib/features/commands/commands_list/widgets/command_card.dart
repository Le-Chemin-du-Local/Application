import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commands/command.dart';
import 'package:chemin_du_local/features/commands/commands_list/widgets/command_card_commerce.dart';
import 'package:flutter/widgets.dart';
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
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 18,),

          for (int i = 0; i < command.commerces.length; ++i) ...{
            Text("Addresse ${i+1}", style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 4,),
            CommandCardCommerce(commerceCommand: command.commerces[i],)
          }
        ],
      ),
    );
  }
}