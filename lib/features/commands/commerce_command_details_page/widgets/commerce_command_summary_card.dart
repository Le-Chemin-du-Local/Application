import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:flutter/material.dart';

class CommerceCommandSummaryCard extends StatelessWidget {
  const CommerceCommandSummaryCard({
    Key? key,
    required this.command
  }) : super(key: key);

  final CommerceCommand command;

  @override
  Widget build(BuildContext context) {
     return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Le titre
          Text(
            "Récapitulatif de commande", 
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w500
            )
          ),
          const SizedBox(height: 18,),

          // Les produits 
          for (final cccommand in command.cccommands)
            for (final product in cccommand.products) ...{
              DefaultTextStyle(
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w500
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.product.name),
                    Text("x${product.quantity}")
                  ],
                ),
              ),
              const SizedBox(height: 8,),
            }

        ],
      ),
    );
  }
}