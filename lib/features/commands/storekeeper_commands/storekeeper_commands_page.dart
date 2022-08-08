import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:chemin_du_local/features/commands/storekeeper_commands/widgets/commands_list.dart';
import 'package:flutter/material.dart';

class StoreKeeperCommandsPage extends StatelessWidget {
  const StoreKeeperCommandsPage({
    Key? key,
    required this.onShowDrawer,
  }) : super(key: key);

  final Function() onShowDrawer;

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CommandsListState> inProgressKey = GlobalKey<CommandsListState>();
    final GlobalKey<CommandsListState> readyKey = GlobalKey<CommandsListState>();

    return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        onShowDrawer: onShowDrawer,
        title: const Text("Mes commandes"),
      ),
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
                    children:[
                      // La liste des commandes à venir
                      Padding(
                        padding: const EdgeInsets.only(right: 13),
                        child: CommandsList(
                          key: inProgressKey,
                          status: CommandStatus.inProgress,
                          title: "Commandes à effectuer",
                          onMustRefetch: () => _refetch(inProgressKey, readyKey),
                        ),
                      ),

                      // La list des commandes prêtes
                      Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: CommandsList(
                          key: readyKey,
                          status: CommandStatus.ready,
                          title: "Commande à distribuer",
                          onMustRefetch: () => _refetch(inProgressKey, readyKey),
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

  void _refetch(GlobalKey<CommandsListState> inProgressKey, GlobalKey<CommandsListState> readyKey) {
    inProgressKey.currentState!.stateRefetch!();
    readyKey.currentState!.stateRefetch!();
  }
}