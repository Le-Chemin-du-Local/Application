import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/basket/basket_commerce.dart';
import 'package:flutter/material.dart';

class BasketCommerceCard extends StatelessWidget {
  const BasketCommerceCard({
    Key? key,
    required this.commerce
  }) : super(key: key);

  final BasketCommerce commerce;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
          height: 36,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  commerce.commerce.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                width: 24, height: 24,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: Center(
                  child: Text(
                    commerce.products.length.toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )
                ),
              )
            ],
          ),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ScreenHelper.horizontalPadding,
              vertical: 10
            ),
            child: ListView(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final product in commerce.products)
                  Text("${product.product.name} (x${product.quantity})"),
                const Divider(),

                for (final panier in commerce.paniers) 
                  Text("Panier : ${panier.name}")
              ],
            ),
          ),
        )
      ],
    );
  }
}