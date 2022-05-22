import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/basket/basket.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_commerce_card.dart';
import 'package:chemin_du_local/features/commands/commands_list/commands_list.dart';
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
                  child: CommandsList(),
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
          child: ClElevatedButton(
            onPressed: basket.commerces.isNotEmpty ? onPay : null, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.shopping_basket_sharp),
                SizedBox(width: 12,),

                Text("Valider mon panier")
              ],
            )
          ),
        ),
        const SizedBox(height: 12,)
      ],
    );
  }
}