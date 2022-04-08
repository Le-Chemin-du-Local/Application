import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/commands/panier_page/widgets/panier_command_category.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier_command.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier_product.dart';
import 'package:flutter/material.dart';

class PanierCommandProductsCard extends StatelessWidget {
  const PanierCommandProductsCard({
    Key? key,
    required this.command,
    required this.onMarkReady
  }) : super(key: key);

  final PanierCommand command;

  final Function() onMarkReady;

  Map<String, List<PanierProduct>> _orderedProducts() {
    Map<String, List<PanierProduct>> result = {};

    for (final product in command.panier.products) {
      final String categorie = product.product.categories.isNotEmpty ? product.product.categories.first : "Autre";

      if (result[categorie] == null) {
        result[categorie] = [product];
      }
      else {
        result[categorie]!.add(product);
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final products = _orderedProducts();

    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final category in products.keys) ...{
            Flexible(
              child: PanierCommandCategory(
                category: category,
                products: products[category]!,
              ),
            ),
            const SizedBox(height: 12,),
          },
          
          ClElevatedButton(
            onPressed: command.status == PanierCommandStatus.inProgress
              ? onMarkReady
              : null,
            child: const Text("Commande prête"),
          )
        ],
      )
    );
  }

}