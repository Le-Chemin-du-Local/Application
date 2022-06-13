import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/user/models/cl_payment_method/cl_payment_method.dart';
import 'package:flutter/material.dart';

class CardCard extends StatelessWidget {
  const CardCard({
    Key? key,
    required this.paymentMethod, 
    required this.choosedPaymentMethod,
    required this.onSelected
  }) : super(key: key);

  final ClPaymentMethod paymentMethod;

  final String choosedPaymentMethod;
  final Function(String?) onSelected;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: Row(
        children: [
          // Le bouton de séléction de la carte
          Radio<String>(
            groupValue: choosedPaymentMethod,
            value: paymentMethod.stripeID ?? "",
            onChanged: onSelected,
          ),
          // Les infos de la carte
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // La marque de la carte et les derniers chiffres
                Flexible(
                  child: Text(
                    "${paymentMethod.cardBrand}  ****${paymentMethod.cardLast4Digits}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500
                    )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}