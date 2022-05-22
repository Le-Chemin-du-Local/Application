import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/commands/command.dart';
import 'package:chemin_du_local/features/commands/commands_graphql.dart';
import 'package:chemin_du_local/features/commands/commands_list/widgets/command_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommandsList extends ConsumerWidget {
  const CommandsList({Key? key}) : super(key: key);

  QueryOptions<dynamic> _commandsQueryOptions(String status) {
    return QueryOptions<dynamic>(
      document: gql(qGetCommandsMini),
      variables: <String, dynamic>{
        "filter": {
          "status": status
        }
      }
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isConnected = ref.read(appUserControllerProvider).token != null;

    if (!isConnected) {
      return const Align(
        alignment: Alignment.topCenter,
        child: ClStatusMessage(
          type: ClStatusMessageType.info,
          message: "Vous devez vous connecter pour voir vos commandes en cours",
        ),
      );
    }

    return Query<dynamic>(
      options: _commandsQueryOptions("INPROGRESS"),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (result.hasException) {
          return const Align(
            alignment: Alignment.topCenter,
            child: ClStatusMessage(
              message: "Nous ne parvenons pas à charger les commandes",
            ),
          );
        }
        
        final List mapCommands = result.data!["commands"]["edges"] as List;
        final List<Command> commands = [];

        for (final mapCommand in mapCommands) {
          commands.add(Command.fromJson(mapCommand["node"] as Map<String, dynamic>));
        }

        if (commands.isEmpty) {
          return Container();
        }

        return _buildContent(commands);
      },
    );
  }

  Widget _buildContent(List<Command> commands) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (final command in commands) 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding, vertical: 8),
            child: CommandCard(command: command),
          )
      ],
    );
  }
}