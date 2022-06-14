import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commands/commands_list_page/commands_list_page.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class PendingCommandsCard extends StatelessWidget {
  const PendingCommandsCard({
    Key? key,
    required this.commandsCount
  }) : super(key: key);

  final int commandsCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onOpenCommandsPage(context),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
          color: Palette.colorTextSuccess
        ),
        child: ClCard(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 18),
          backgroundColor: Palette.colorBackgroundSuccess,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text("Vous avez $commandsCount commande(s) en cours",),
              ),
              const Icon(
                Icons.chevron_right, 
                size: 24,
                color: Palette.colorTextSuccess,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future _onOpenCommandsPage(BuildContext context) async {
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => const CommandsListPage()
      )
    );
  }
}