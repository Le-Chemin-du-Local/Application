import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commands/commands_list/widgets/command_card_commerce.dart';
import 'package:chemin_du_local/features/commands/commerce_command_details_page/commerce_command_details_page.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:flutter/material.dart';

class CommandCommercesList extends StatelessWidget {
  const CommandCommercesList({
    Key? key,
    required this.commerceCommands,
    required this.onCommerceCommandDone,
  }) : super(key: key);

  final List<CommerceCommand> commerceCommands;

  final Function() onCommerceCommandDone;

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (final command in commerceCommands) ...{
          InkWell(
            onTap: () => _openCommerceCommandDetails(context, command),
            child: ClCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Le titre
                  Text(
                    command.commerce?.name ?? "Nom inconnue", 
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(height: 18,),

                  CommandCardCommerce(commerceCommand: command)
                ],
              ),
            ),
          ),
          const SizedBox(height: 12,),
        }
      ],
    );
  }

  Future _openCommerceCommandDetails(BuildContext context, CommerceCommand commerceCommand) async {
    final bool commerceDone = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => CommerceCommandDetailsPage(commerceCommand: commerceCommand)
      )
    ) ?? false;

    if (commerceDone) {
      onCommerceCommandDone();
    }
  }
}