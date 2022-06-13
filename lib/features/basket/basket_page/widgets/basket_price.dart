import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:flutter/material.dart';

class BasketPrice extends StatelessWidget {
  const BasketPrice({
    Key? key,
    required this.basket
  }) : super(key: key);
  
  final Basket basket;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sous-total (${_calculateTotalItems()} articles)", style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500
            ),),
            Text("${calculatePrice(basket).toStringAsFixed(2)}€", style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500
            ),)
          ],
        ),
        const SizedBox(height: 6,),

        // La remise potentielle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Remise", style: Theme.of(context).textTheme.titleMedium,),
            Text("0€", style: Theme.of(context).textTheme.titleMedium)
          ],
        ),
        const SizedBox(height: 6,),

        // Le total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary
            ),),
            Text("${calculatePrice(basket).toStringAsFixed(2)}€", style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.secondary
            ),)
          ],
        ),
      ],
    );
  }

  int _calculateTotalItems() {
    int result = 0;
    for (final commerce in basket.commerces) {
      result += commerce.paniers.length;
      for (final product in commerce.products) {
        result += product.quantity;
      }
    }

    return result;
  }

  static double calculatePrice(Basket basket) {
    double price = 0.0;

    for (final commerce in basket.commerces) {
      for (final product in commerce.products) {
        price += ((product.product.price ?? 0) * product.quantity);
      }

      for (final panier in commerce.paniers) {
        price += panier.price;
      }
    } 

    return price;
  }
}