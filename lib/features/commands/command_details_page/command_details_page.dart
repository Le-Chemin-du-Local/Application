import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commands/command_details_page/widgets/command_commerces_list.dart';
import 'package:chemin_du_local/features/commands/command_details_page/widgets/command_summary_card.dart';
import 'package:chemin_du_local/features/commands/commands_graphql.dart';
import 'package:chemin_du_local/features/commands/models/command/command.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommandDetailsPage extends StatelessWidget {
  const CommandDetailsPage({
    Key? key,
    required this.commandID,
    required this.commandDateString
  }) : super(key: key);

  final String commandID;
  final String commandDateString;

  QueryOptions _commandQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qGetCommandDetailed),
      variables: <String, dynamic>{
        "id": commandID
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("commande du $commandDateString"),
      ),
      body: Query<dynamic>(
        options: _commandQueryOptions(),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (result.hasException) {
            return const Align(
              alignment: Alignment.topCenter, 
              child: ClStatusMessage(
                message: "Nous ne parvenons pas à récupérer la commande",
              ),
            );
          }

          final Command command = Command.fromJson(result.data!["command"] as Map<String, dynamic>);

          return _buildContent(context, command, refetch);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, Command command, Refetch? refetch) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: ScreenHelper.instance.horizontalPadding
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text descriptif
            Text(
              "Présentez-vous au commerce au créneau de collecte indiqué en lui présentant la carte associée à l’adresse. Il validera ce reçu et vous pourrez repartir avec les produits de votre commerçant préféré 😉",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24,),

            // Le résumé
            CommandSummaryCard(command: command),
            const SizedBox(height: 12,),

            // La liste des commerces
            CommandCommercesList(
              commerceCommands: command.commerces,
              onCommerceCommandDone: () => _onCommerceCommandDone(context, command, refetch),
            ),
          ],
        ),
      ),
    );
  }

  void _onCommerceCommandDone(BuildContext context, Command command, Refetch? refetch) {
    if (command.commerces.length > 1) {
      if (refetch != null) {
        refetch();
      }
    }
    else {
      Navigator.of(context).pop(true);
    }
  }
}