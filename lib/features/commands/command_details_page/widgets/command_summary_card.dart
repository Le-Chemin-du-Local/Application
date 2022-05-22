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
          Text("Récapitulatif de command", style: Theme.of(context).textTheme.headline2),
          const SizedBox(height: 18,),

          // Le sous total
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.bold
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sous total (${command.totalCount} articles)"),
                Text("${command.totalPrice}€")
              ],
            ),
          ),
          const SizedBox(height: 8,),

          // Le total
          DefaultTextStyle(
            style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Theme.of(context).primaryColor
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