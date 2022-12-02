import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commands/commands_graphql.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:chemin_du_local/features/commands/storekeeper_commands/command_details_page/widgets/cc_list.dart';
import 'package:chemin_du_local/features/commands/storekeeper_commands/command_details_page/widgets/paniers_list.dart';
import 'package:chemin_du_local/features/commands/storekeeper_commands/command_details_page/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommandDetailsPage extends StatelessWidget {
  const CommandDetailsPage({
    Key? key,
    required this.command
  }) : super(key: key);

  final CommerceCommand command;

  MutationOptions updateCommandOptions(BuildContext context) {
    return MutationOptions<dynamic>(
      document: gql(mutUpdateCommerceCommand),
      onCompleted: (dynamic data) {
        if (data == null) return;
        Navigator.of(context).pop(true);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: const Text("Détails de la commande"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.instance.horizontalPadding,
            vertical: 12
          ),
          child: Mutation<dynamic>(
            options: updateCommandOptions(context),
            builder: (runMutation, mutationResult) {
              if (mutationResult?.isLoading ?? false) {
                return const Center(child: CircularProgressIndicator(),);
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Erreur si il y a 
                  if (mutationResult?.hasException ?? false) ...{
                    const ClStatusMessage(
                      message: "Nous n'arrivons pas à mettre à jour la commande",
                    ),
                    const SizedBox(height: 20,),
                  },

                  // Les infos utilisateur
                  Flexible(
                    child: UserCard(command: command),
                  ),
                  const SizedBox(height: 12,),

                  // La commande
                  Flexible(
                    child: ClCard(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (command.cccommands.isNotEmpty) ...{
                            Flexible(child: CCList(command: command.cccommands.first),),
                            const SizedBox(height: 20,),
                          },
                          if (command.panierCommands.isNotEmpty) ...{
                            Flexible(child: PaniersList(paniers: command.panierCommands,)),
                            const SizedBox(height: 20,),
                          },

                          // Le total
                          Text(
                            "Total",
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                              color: Theme.of(context).colorScheme.secondary
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(height: 20,),

                          // Les boutons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // Le bouton de validation
                              ElevatedButton.icon(
                                onPressed: command.status == CommandStatus.inProgress ? () => _markCommandReady(runMutation) : null,
                                icon: const Icon(Icons.check), 
                                label: const Text("Commande prête")
                              ),
                              const SizedBox(width: 4,),

                              // Le bouton pour annuler
                              OutlinedButton.icon(
                                onPressed: command.status == CommandStatus.inProgress ? () => _markCommandCanceled(runMutation) : null, 
                                icon: const Icon(Icons.close), 
                                label: const Text('Annuler la commande')
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  void _markCommandReady(RunMutation? runMutation) {
    if (runMutation != null) {
      runMutation(<String, dynamic>{
        "id": command.id,
        "changes": <String, dynamic>{
          "status": CommandStatus.ready
        }
      });
    }
  }

  void _markCommandCanceled(RunMutation? runMutation) {
    if (runMutation != null) {
      runMutation(<String, dynamic>{
        "id": command.id,
        "changes": <String, dynamic>{
          "status": CommandStatus.canceled,
        }
      });
    }
  }
}