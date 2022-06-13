import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_price.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:flutter/material.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    Key? key,
    required this.basket
  }) : super(key: key);

  final Basket basket;

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
            ),
          ),
          const SizedBox(height: 18,),

          // Le contenue
          BasketPrice(basket: basket)
        ],
      ),
    );
  }
}