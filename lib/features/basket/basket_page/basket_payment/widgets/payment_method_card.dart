import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/user/models/cl_payment_method/cl_payment_method.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    Key? key,
    required this.appUser,
    required this.paymentMethodId,
  }) : super(key: key);

  final User appUser;
  final String paymentMethodId;

  @override
  Widget build(BuildContext context) {
    ClPaymentMethod? paymentMethod;
    for (final userPaymentMethod in appUser.registeredPaymentMethods) {
      if (userPaymentMethod.stripeID == paymentMethodId) {
        paymentMethod = userPaymentMethod;
        break;
      }
    }

    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Le titre
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Informations de paiement", 
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(width: 4,),

              const Icon(
                Icons.chevron_right_rounded,
                size: 24,
              )
            ],
          ),
          const SizedBox(height: 18,),

          // La marque de la carte
          Text(
            paymentMethod == null 
              ? "Aucun moyen de paiement"
              : "Carte ${paymentMethod.cardBrand}",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 4,),

          // Les infos de la carte
          Text(
            paymentMethod == null 
              ? "Renseignez votre moyen de paiement"
              : "${paymentMethod.cardBrand} ****-${paymentMethod.cardLast4Digits}",
            style: Theme.of(context).textTheme.titleMedium,
          )

        ]
      ),
    );
  }
}