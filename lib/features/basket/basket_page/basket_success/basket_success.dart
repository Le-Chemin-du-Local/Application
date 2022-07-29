import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/steps_indicator.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment/widgets/summary_card.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_success/widgets/adresses_summary.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_summary/basket_summary.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:flutter/material.dart';

class BasketSuccess extends StatelessWidget {
  const BasketSuccess({
    Key? key,
    required this.basket,
  }) : super(key: key);

  final Basket basket;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 54 - ScreenHelper.instance.horizontalPadding,
          ),
          child: StepsIndicator(
            currentStep: 3, 
            stepsTitle: const [
              "Panier", "Crénaux", "Coordonnées", "Confirmation",
            ], 
            onStepClicked: (step) {}
          ),
        ),

        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenHelper.instance.horizontalPadding,
                vertical: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Le texte de félicitation
                  Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 48,
                        color: Color(0xff63d266),
                      ),
                      const SizedBox(width: 12,),

                      Flexible(
                        child: Text(
                          "Nous vous remercions de votre commande !",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 18,),

                  // Le texte résumé
                  const Text(
                    "Votre commande est complète et a bien été prise en compte. Une fois votre commande validée et prête, vous recevrez une notification pour la retirer."
                  ),
                  const SizedBox(height: 24,),

                  // Le récapitulatif
                  SummaryCard(basket: basket),
                  const SizedBox(height: 24,),

                  // Les adresses
                  AddressesSummary(basket: basket),
                  
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}