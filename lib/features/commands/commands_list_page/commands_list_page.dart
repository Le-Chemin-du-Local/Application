import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/features/commands/commands_list_page/widgets/commands_list.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:flutter/material.dart';

class CommandsListPage extends StatelessWidget {
  const CommandsListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: const Text("Mes commandes")
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.instance.horizontalPadding
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Le titre
              Text(
                "Commande à retirer", 
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(height: 12),

              // Les commandes en cours
              const Flexible(
                child: CommandsList(
                  status: [
                    CommandStatus.inProgress,
                    CommandStatus.ready
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}