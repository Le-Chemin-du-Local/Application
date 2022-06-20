import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommandCard extends StatelessWidget {
  const CommandCard({
    Key? key, 
    required this.command,
  }) : super(key: key);

  final CommerceCommand command;

  @override
  Widget build(BuildContext context) {
    final useBigLayout = command.status == CommandStatus.done;
    final dateString = command.pickupDate == null ? "Non défini" : DateFormat("dd/MM/yyyy").format(command.pickupDate!);
    final hoursString = command.pickupDate == null ? "Non défini" : DateFormat("hh:mm").format(command.pickupDate!);
    Color backgroundColor = Theme.of(context).colorScheme.surface;

    if (command.status == CommandStatus.ready) {
      backgroundColor = const Color(0xffb8ffba);
    }
    else if (command.status == CommandStatus.done) {
      backgroundColor = const Color(0xffdadada);
    }

    return ClCard(
      backgroundColor: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Le header, si besoin
          if (!useBigLayout) 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Le nom et prénom
                Expanded(
                  child: Text(
                    "${command.user?.firstName} ${command.user?.lastName}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
            
                // L'index
                Text("#001", style: Theme.of(context).textTheme.titleMedium,)
              ],
            ),

            // Les infos
            GridView(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 50
              ),
              children: [
                if (useBigLayout) ...{
                  Text("${command.user?.firstName} ${command.user?.lastName}"),
                  const Text("#0001")
                },
            
                _buildIconText(Icons.calendar_today, dateString),
                _buildIconText(Icons.watch_later_outlined, hoursString),
                _buildIconText(Icons.wallet, (command.price ?? 0.0).toStringAsFixed(2)),
              ],
            )
        ],
      ),
    );
  }


  Widget _buildIconText(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24,
        ),
        const SizedBox(width: 5,),

        Text(text)
      ],
    );
  }
}