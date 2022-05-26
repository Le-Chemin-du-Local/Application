import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/commands/command_details_page/command_details_page.dart';
import 'package:chemin_du_local/features/commands/commands_graphql.dart';
import 'package:chemin_du_local/features/commands/commands_list/widgets/command_card.dart';
import 'package:chemin_du_local/features/commands/models/command/command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class CommandsList extends ConsumerWidget {
  const CommandsList({
    Key? key,
    required this.status,
  }) : super(key: key);

  final List<String> status;

  QueryOptions<dynamic> _commandsQueryOptions() {
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
      options: _commandsQueryOptions(),
      builder: (QueryResult result, { fetchMore, refetch }) {
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

        return _buildContent(context, commands, refetch);
      },
    );
  }

  Widget _buildContent(BuildContext context, List<Command> commands, Refetch? refetch) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (final command in commands) 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding, vertical: 8),
            child: InkWell(
              onTap: () => _openCommandDetail(context, command, refetch),
              child: CommandCard(command: command)
            ),
          )
      ],
    );
  }

  Future _openCommandDetail(BuildContext context, Command command, Refetch? refetch) async {
    final String creationDateString = command.creationDate != null 
      ? DateFormat("dd/MM/yyyy").format(command.creationDate!)
      : "Date inconnue";

      bool shouldRefetch = await Navigator.of(context).push<bool?>(
        MaterialPageRoute<bool?>(
          builder: (context) => CommandDetailsPage(
            commandID: command.id!,
            commandDateString: creationDateString
          )
        )
      ) ?? false;

      if (shouldRefetch && refetch != null) {
        refetch();
      } 
  }
}