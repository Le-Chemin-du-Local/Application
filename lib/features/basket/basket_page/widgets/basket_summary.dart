import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/basket/basket.dart';
import 'package:chemin_du_local/features/basket/basket_controller.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_commerce_card.dart';
import 'package:chemin_du_local/features/basket/basket_product.dart';
import 'package:chemin_du_local/features/basket/basket_state.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketSummary extends ConsumerWidget {
  const BasketSummary({
    Key? key,
    required this.onPay,
  }) : super(key: key);

  final Function() onPay;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
      child: ref.watch(basketControllerProvider).basket.when(
        data: (data) => _buildContent(data),
        loading: () => const Center(child: CircularProgressIndicator(),),
        error: (error, stackTrace) => const Align(
          alignment: Alignment.topCenter,
          child: ClStatusMessage(
            message: "Nous n'arrivons pas à charger votre panier...",
          ),
        )
      ),
    );
  }

  Widget _buildContent(Basket basket) {
    return Column(
      children: [
        // La liste des produits
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final commerce in basket.commerces)
                  BasketCommerceCard(commerce: commerce)
              ],
            ),
          ),
        ),

        // Le bouton
        ClElevatedButton(
          onPressed: onPay, 
          child: Row(
            children: const [
              Icon(Icons.shopping_basket_sharp),
              SizedBox(width: 12,),

              Text("Valider mon panier")
            ],
          )
        ),
        const SizedBox(height: 12,)
      ],
    );
  }
}