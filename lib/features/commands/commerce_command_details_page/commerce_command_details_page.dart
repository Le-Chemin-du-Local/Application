import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/commands/commerce_command_details_page/widgets/commerce_command_summary_card.dart';
import 'package:chemin_du_local/features/commands/commerce_command_details_page/widgets/commerce_info_card.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommerceCommandDetailsPage extends StatelessWidget {
  const CommerceCommandDetailsPage({
    Key? key,
    required this.commerceCommand,
    required this.commandIndex
  }) : super(key: key);

  final CommerceCommand commerceCommand;
  final int commandIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adresse $commandIndex"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: ScreenHelper.horizontalPadding
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text descriptif
              const Text("Présentez-vous au commerce au créneau de collecte indiqué en lui présentant la carte associée à l’adresse. Il validera ce reçu et vous pourrez repartir avec les produits de votre commerçant préféré 😉"),
              const SizedBox(height: 24,),

              // Le recapitluatif
              CommerceCommandSummaryCard(command: commerceCommand),
              const SizedBox(height: 12,),

              // Les infos sur le commerce
              if (commerceCommand.commerce != null)
                CommerceInfoCard(commerce: commerceCommand.commerce!)
            ],
          ),
        ),
      )
    );
  }
}