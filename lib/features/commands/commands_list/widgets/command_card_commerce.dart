import 'package:chemin_du_local/core/widgets/badge.dart';
import 'package:chemin_du_local/features/commands/commerce_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class CommandCardCommerce extends StatelessWidget {
  const CommandCardCommerce({
    Key? key,
    required this.commerceCommand
  }) : super(key: key);

  final CommerceCommand commerceCommand;

  @override
  Widget build(BuildContext context) {
    final DateTime? pickupStartDate = commerceCommand.pickupDate;
    final DateTime? pickupEndDate = pickupStartDate?.add(const Duration(minutes: 30));

    final String collectDateString = pickupStartDate == null 
      ? "Date non définie"
      : "${DateFormat("dd/MM/yyyy").format(pickupStartDate)} -> ${DateFormat("hh:mm").format(pickupStartDate)} - ${DateFormat("hh:mm").format(pickupEndDate!)}";

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText1!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Les infos du commerces
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(commerceCommand.commerce?.address ?? "Addresse inconnue"),
                Text("Collecte : $collectDateString")
              ],
            ),
          ),
          const SizedBox(width: 24,),
    
          // Le badge de status
          const Badge(child: Text("En cours"))
        ],
      ),
    );
  }
}