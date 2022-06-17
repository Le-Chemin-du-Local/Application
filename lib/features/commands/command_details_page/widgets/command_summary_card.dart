import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commands/models/command/command.dart';
import 'package:flutter/material.dart';

class CommandSummaryCard extends StatelessWidget {
  const CommandSummaryCard({
    Key? key,
    required this.command
  }) : super(key: key);

  final Command command;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Le titre
          Text(
            "Récapitulatif de command",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w500
            )
          ),
          const SizedBox(height: 18,),

          // Le sous total
          DefaultTextStyle(
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sous total (${command.totalCount} articles)"),
                Text("${command.totalPrice.toStringAsFixed(2)}€")
              ],
            ),
          ),
          const SizedBox(height: 8,),

          // Le total
          DefaultTextStyle(
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Totale TTC"),
                Text("${command.totalPrice}€")
              ],
            ),
          )
        ],
      ),
    );
  }
}