import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/cccommand.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/cccommand_page/widgets/cccommand_category.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/ccproduct.dart';
import 'package:flutter/material.dart';

class CCCommandProductsCard extends StatelessWidget {
  const CCCommandProductsCard({
    Key? key,
    required this.command,
    required this.onMarkReady
  }) : super(key: key);

  final CCCommand command;

  final Function() onMarkReady;

  Map<String, List<CCProduct>> _orderedProducts() {
    Map<String, List<CCProduct>> result = {};

    for (final product in command.products) {
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
              child: CCCommandCategory(
                category: category,
                products: products[category]!,
              ),
            ),
            const SizedBox(height: 12,),
          },
          
          ClElevatedButton(
            onPressed: command.status == CCCommandStatus.inProgress
              ? onMarkReady
              : null,
            child: const Text("Commande prête"),
          )
        ],
      )
    );
  }

}