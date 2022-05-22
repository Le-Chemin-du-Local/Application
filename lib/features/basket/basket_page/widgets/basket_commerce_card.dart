import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_product_card.dart';
import 'package:chemin_du_local/features/basket/models/basket_commerce/basket_commerce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketCommerceCard extends ConsumerWidget {
  const BasketCommerceCard({
    Key? key,
    required this.commerce
  }) : super(key: key);

  final BasketCommerce commerce;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: ListView(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final product in commerce.products)
                BasketProductCard(product: product,),
              const Divider(),

              for (final panier in commerce.paniers) 
                Text("Panier : ${panier.name}")
            ],
          ),
        )
      ],
    );
  }
}