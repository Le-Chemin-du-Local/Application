import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/cccommand.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CCCommandUserCard extends StatelessWidget {
  const CCCommandUserCard({
    Key? key,
    required this.command
  }) : super(key: key);

  final CCCommand command;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Le nom
          Text(
            "${command.user?.firstName ?? ""} ${command.user?.lastName ?? ""}",
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20,),

          // // Date & heure
          const Text("Commande à préparer pour le", style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 18,),
          Flexible(child: _buildIconedInfo(Icons.calendar_today, DateFormat("dd/MM/yyyy").format(command.pickupDate))),
          const SizedBox(height: 12,),
          Flexible(child: _buildIconedInfo(Icons.access_time, DateFormat.Hm().format(command.pickupDate))),
          const SizedBox(height: 20,),

          // Contact
          const Text("Contact", style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 12,),
          Text(command.user?.email ?? "email inconnue")

        ],
      ),
    );
  }

  Widget _buildIconedInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(width: 4,),

        Text(text)
      ],
    );
  }
}