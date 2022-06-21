import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.command
  }) : super(key: key);

  final CommerceCommand command;

  @override
  Widget build(BuildContext context) {
    final dateString = command.pickupDate == null ? "Non défini" : DateFormat("dd/MM/yyyy").format(command.pickupDate!);
    final hoursString = command.pickupDate == null 
      ? "Non défini"
      : "${DateFormat("hh:mm").format(command.pickupDate!)} - ${DateFormat("hh:mm").format(command.pickupDate!.add(const Duration(minutes: 30)))}";
    
    return ClCard(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenHelper.instance.horizontalPadding,
        vertical: 26
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Les infos global
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildInfo(context, Icons.person_outline, "${command.user?.firstName} ${command.user?.lastName}"),
              _buildInfo(context, Icons.receipt_outlined, "#0001"),
              _buildInfo(context, Icons.calendar_today_outlined, "Pour le $dateString"),
              _buildInfo(context, Icons.schedule_outlined, hoursString),
              _buildInfo(context, Icons.wallet_outlined, "${(command.price ?? 0).toStringAsFixed(2)}€")
            ],
          ),
          const SizedBox(height: 12,),

          // Les infos de contact et les boutons
          LayoutBuilder(
            builder: (context, constraints) {
              final List<Widget> children = [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Le téléphone
                      Text(command.user?.phone ?? "Non défini", style: const TextStyle(fontWeight: FontWeight.w500),),
                      // L'email
                      Text(command.user?.email ?? "Non défini"),
                    ],
                  ),
                ),

                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_android),
                  label: const Text("Appeler le client")
                )
              ];

              if (constraints.maxWidth >= ScreenHelper.breakpointPC) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: children
                );
              } 

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context, IconData icon, String text) {
    return SizedBox(
      width: 200,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
          ),
          const SizedBox(width: 5,),

          Text(text, style: Theme.of(context).textTheme.titleMedium,),
        ],
      ),
    );
  }
}