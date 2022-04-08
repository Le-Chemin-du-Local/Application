import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commands/widgets/panier_command_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/cccommand.dart';
import 'package:chemin_du_local/features/commands/widgets/cccommand_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier_command.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ReadyCommandList extends StatelessWidget {
  const ReadyCommandList({
    Key? key,
    required this.queryResult,
    required this.panierQueryResult,
    required this.runMutation,
    required this.runPanierMutation,
    required this.filter,
  }) : super(key: key);

  final QueryResult<dynamic> queryResult;
  final QueryResult<dynamic> panierQueryResult;

  final RunMutation? runMutation;
  final RunMutation? runPanierMutation;

  final String filter;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Commandes prêtes", style: Theme.of(context).textTheme.headline2,),
        const SizedBox(height: 20,),

        Flexible(
          child: Builder(
            builder: (context) {
              if (queryResult.isLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }

              if (queryResult.hasException) {
                return const Align(
                  alignment: Alignment.topCenter,
                  child: ClStatusMessage(
                    message: "Nous ne parvenons pas à récupérer les commandes prêtes...",
                  ),
                );
              }

              final List mapCCCommands = queryResult.data!["commerce"]["cccommands"]["edges"] as List;
              final List<CCCommand> cccommands = [];

              for (final mapCCCommand in mapCCCommands) {
                cccommands.add(CCCommand.fromJson(mapCCCommand["node"] as Map<String, dynamic>));
              }

              final List mapPanierCommands = panierQueryResult.data!["commerce"]["panierCommands"]["edges"] as List;
              final List<PanierCommand> panierCommands = [];

              for (final mapPanierCommand in mapPanierCommands) {
                panierCommands.add(PanierCommand.fromJson(mapPanierCommand["node"] as Map<String, dynamic>));
              }

              return _buildContent(_commandsInUserOrder(cccommands, panierCommands));
            },
          ),
        )
      ],
    );
  }

  Widget _buildContent(
    Map<String, List<dynamic>> commands
  ) {
    return ListView(
      children: [
        for (final user in commands.keys)
          for (final command in commands[user]!)
            if (command is CCCommand && (filter.isEmpty || filter == "clickandcollect"))
              CCCommandCard(
                command: command, 
                index: 0,
                onMarkAsDone: () => _markCommandAsDone(command.id!),
                runMutation: runMutation,
              )
            else if (command is PanierCommand && (filter.isEmpty || filter == "paniers"))
              PanierCommandCard(
                command: command, 
                index: 0, 
                onMarkAsDone: () => _markPanierCommandAsDone(command.id!),
                runMutation: runPanierMutation
              ) 
      ],
    );
  }

  Map<String, List<dynamic>> _commandsInUserOrder(
    List<CCCommand> cccommands,
    List<PanierCommand> panierCommands,
  ) {
    final Map<String, List<dynamic>> result = {};

    for (final cccommand in cccommands) {
      if (result[cccommand.user?.id] == null) {
        result[cccommand.user!.id!] = <dynamic>[
          cccommand
        ];
      }
      else {
        result[cccommand.user!.id!]!.add(cccommand);
      }
    }

    for (final panierCommand in panierCommands) {
      if (result[panierCommand.user?.id] == null) {
        result[panierCommand.user!.id!] = <dynamic>[
          panierCommand
        ];
      }
      else {
        result[panierCommand.user!.id!]!.add(panierCommand);
      }
    }

    return result;
  }

  void _markCommandAsDone(String cccommandId) {
    if (runMutation != null) {
      runMutation!(<String, dynamic>{
        "id": cccommandId,
        "status": CCCommandStatus.done
      });
    }
  }

  void _markPanierCommandAsDone(String panierCommandId) {
    if (runPanierMutation != null) {
      runPanierMutation!(<String, dynamic>{
        "id": panierCommandId,
        "status": CCCommandStatus.done
      });
    }
  }
}