import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commands/commands_graphql.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:chemin_du_local/features/commands/storekeeper_commands/command_details_page/command_details_page.dart';
import 'package:chemin_du_local/features/commands/storekeeper_commands/widgets/command_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommandsList extends StatefulWidget {
  const CommandsList({
    Key? key,
    required this.status,
    required this.title,
    required this.onMustRefetch,
  }) : super(key: key);

  final String status;
  final String title;

  final Function() onMustRefetch;

  @override
  State<CommandsList> createState() => CommandsListState();
}

class CommandsListState extends State<CommandsList> {
  Refetch? stateRefetch;

  QueryOptions getCommandsQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qGetCommerceCommands), 
      variables: <String, dynamic>{
        "filter": <String, dynamic>{
          "status": [
            widget.status
          ]
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Le titre
        Flexible(
          child: Text(widget.title, style: Theme.of(context).textTheme.headlineMedium,),
        ),
        const SizedBox(height: 20,),

        // Le contenue
        Flexible(
          child: Query<dynamic>(
            options: getCommandsQueryOptions(), 
            builder: (result, {fetchMore, refetch}) {
              stateRefetch = refetch;

              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
        
              if (result.hasException) {
                return const Align(
                  alignment: Alignment.topLeft,
                  child: ClStatusMessage(
                    message: "Nous n'avons pas pu charger les commandes...",
                  ),
                );
              }
        
              final List mapCommands = result.data!["commerceCommands"]["edges"] as List;
              final List<CommerceCommand> commands = [];
        
              for (final mapCommand in mapCommands) {
                commands.add(CommerceCommand.fromJson(mapCommand["node"] as Map<String, dynamic>));
              }
        
              if (commands.isEmpty) {
                return const Align(
                  alignment: Alignment.topLeft,
                  child: ClStatusMessage(
                    type: ClStatusMessageType.info,
                    message: "Vous n'avez pas de commandes ici.",
                  ),
                );
              }
        
              return _buildContent(context, commands: commands, refetch: refetch);
            }
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context, {
    required List<CommerceCommand> commands,
    Refetch? refetch,
  }) {
    return ListView(
      shrinkWrap: true,
      children: [
        for (final command in commands) ...{ 
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 138),
            child: InkWell(
              onTap: () => _onOpenCommandDetails(context, command),
              child: CommandCard(command: command)
            ),
          ),
          const SizedBox(height: 21,)
        }
      ],
    );
  }

  Future _onOpenCommandDetails(BuildContext context, CommerceCommand command) async {
    final bool shouldRefetch = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
       builder: (context) => CommandDetailsPage(command: command)
      )
    ) ?? false;

    if (shouldRefetch) {
      widget.onMustRefetch();
    }
  }
}