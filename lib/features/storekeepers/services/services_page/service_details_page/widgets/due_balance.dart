import 'package:chemin_du_local/core/utils/dates_helper.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DueBalance extends StatelessWidget {
  const DueBalance({Key? key, required this.commerce}) : super(key: key);

  final Commerce commerce;

  @override
  Widget build(BuildContext context) {
    final bool isBilledToday = commerce.firstBillingDate == null ? false : DateTime.now().isSameDate(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        commerce.firstBillingDate!.day
      )
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "${(commerce.dueBalance ?? 0).toStringAsFixed(2)}€",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.secondary
          ),
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w500
            ),
            children: [
              TextSpan(
                text: "Sole actuellement dû pour ${isBilledToday ? "": "le "}"
              ),
              TextSpan(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary
                ),
                text: isBilledToday 
                ? "Aujourd'hui" 
                : DateFormat("dd/MM/yyyy").format(
                    DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      commerce.firstBillingDate!.day
                    )
                  )
              )
            ]
          ),
        )
      ],
    );
  }
}