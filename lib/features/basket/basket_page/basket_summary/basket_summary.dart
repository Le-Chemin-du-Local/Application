import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_summary/widgets/basket_commerce_card.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_price.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
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
                // TODO: Normalement Marion devrait rajouter un bouton
                // // La liste des commandes
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
                //   child: Text(
                //     "Commandes à retirer", 
                //     style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                //       fontWeight: FontWeight.w500
                //     ),
                //   ),
                // ),
                // const Flexible(
                //   child: CommandsList(
                //     status: [
                //       CommandStatus.inProgress,
                //       CommandStatus.ready,
                //     ],
                //   ),
                // ),
                
                // La liste des produits
                for (final commerce in basket.commerces)
                  BasketCommerceCard(commerce: commerce),
              ],
            ),
          ),
        ),

        // Le bouton
        Container(
          color: Theme.of(context).colorScheme.surface,
          padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.instance.horizontalPadding,
            vertical: 14
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Le prix
              BasketPrice(basket: basket),
              const SizedBox(height: 26,),

              ElevatedButton(
                onPressed: basket.commerces.isNotEmpty ? onPay : null, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.shopping_basket_sharp),
                    SizedBox(width: 12,),

                    Text("Passer ma commande")
                  ],
                ),
              ),
              const SizedBox(height: 8,)
            ],
          ),
        ),
      ],
    );
  }
}