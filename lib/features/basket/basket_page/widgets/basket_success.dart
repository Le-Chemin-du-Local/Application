import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/basket/basket.dart';
import 'package:flutter/material.dart';

class BasketSuccess extends StatelessWidget {
  const BasketSuccess({
    Key? key,
    required this.basket,
  }) : super(key: key);

  final Basket basket;

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(ScreenHelper.horizontalPadding),
      child: Text("Nous vous remercions de votre commande !"),
    );
  }
}