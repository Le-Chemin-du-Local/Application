import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commands/models/command/command.dart';
import 'package:flutter/material.dart';

class CommandNumberCard extends StatelessWidget {
  const CommandNumberCard({Key? key, required this.command}) : super(key: key);

  final Command command;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Numéro de commande",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500
            ),
          ),

          // Le numéro de commande
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(command.id ?? "Inconnue"),
              ),
              const SizedBox(width: 8,),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.copy)
              ),
            ],
          )
        ],
      ),
    );
  }
}