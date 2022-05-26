import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_commerce_card.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/commands/commands_list/commands_list.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketSummary extends ConsumerWidget {
  const BasketSummary({
    Key? key,
    required this.basket,
    required this.onPay,
  }) : super(key: key);

  final Basket basket;
  final Function() onPay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // La liste des commandes et produits
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // La liste des commandes
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
                  child: Text("Commandes à retirer", style: Theme.of(context).textTheme.headline2,),
                ),
                const Flexible(
                  child: CommandsList(
                    status: [
                      CommandStatus.inProgress,
                      CommandStatus.ready,
                    ],
                  ),
                ),
                
                // La liste des produits
                for (final commerce in basket.commerces)
                  BasketCommerceCard(commerce: commerce),
              ],
            ),
          ),
        ),

        // Le bouton
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ScreenHelper.horizontalPadding,
            vertical: 10
          ),
          child: ElevatedButton(
            onPressed: basket.commerces.isNotEmpty ? onPay : null, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.shopping_basket_sharp),
                SizedBox(width: 12,),

                Text("Passer ma commande")
              ],
            )
          ),
        ),
        const SizedBox(height: 12,)
      ],
    );
  }
}