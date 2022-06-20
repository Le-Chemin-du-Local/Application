import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commands/commands_graphql.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:chemin_du_local/features/commands/storekeeper_commands/widgets/command_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommandsList extends StatelessWidget {
  const CommandsList({
    Key? key,
    required this.status,
    required this.title,
  }) : super(key: key);

  final String status;
  final String title;

  QueryOptions getCommandsQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qGetCommerceCommands), 
      variables: <String, dynamic>{
        "filter": <String, dynamic>{
          "status": [
            status
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
          child: Text(title, style: Theme.of(context).textTheme.headlineMedium,),
        ),
        const SizedBox(height: 20,),

        // Le contenue
        Flexible(
          child: Query<dynamic>(
            options: getCommandsQueryOptions(), 
            builder: (result, {fetchMore, refetch}) {
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
        
              return _buildContent(commands: commands);
            }
          ),
        ),
      ],
    );
  }

  Widget _buildContent({
    required List<CommerceCommand> commands
  }) {
    return ListView(
      shrinkWrap: true,
      children: [
        for (final command in commands) ...{ 
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 130),
            child: CommandCard(command: command),
          ),
          const SizedBox(height: 21,)
        }
      ],
    );
  }
}