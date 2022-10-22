import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/user/models/cl_payment_method/cl_payment_method.dart';
import 'package:flutter/material.dart';

class CardCard extends StatelessWidget {
  const CardCard({
    Key? key,
    required this.paymentMethod, 
    required this.onModify,
  }) : super(key: key);

  final ClPaymentMethod paymentMethod;

  final Function() onModify;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // La marque de la carte et les derniers chiffres
          Flexible(
            child: Text(
              "${paymentMethod.cardBrand}  ****${paymentMethod.cardLast4Digits}",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w500
              )
            ),
          ),

          // Le bouton de modification
          ElevatedButton(
            onPressed: onModify,
            child: const Text("Modifier"),
          )
        ],
      ),
    );
  }
}