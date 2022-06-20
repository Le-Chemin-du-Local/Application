import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:chemin_du_local/features/commands/storekeeper_commands/widgets/commands_list.dart';
import 'package:flutter/material.dart';

class StoreKeeperCommandsPage extends StatelessWidget {
  const StoreKeeperCommandsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: constraints.maxWidth >= ScreenHelper.breakpointTablet ? 2 : 1,
                    ),
                    children: const [
                      // La liste des commandes à venir
                      Padding(
                        padding: EdgeInsets.only(right: 13),
                        child: CommandsList(
                          status: CommandStatus.inProgress,
                          title: "Commandes à effectuer",
                        ),
                      ),

                      // La list des commandes prêtes
                      Padding(
                        padding: EdgeInsets.only(left: 13),
                        child: CommandsList(
                          status: CommandStatus.ready,
                          title: "Commande à distribuer",
                        ),
                      )
                    ],
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}