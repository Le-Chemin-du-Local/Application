import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/cccommand.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/widgets/cccommand_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CCInProgressCommandList extends StatelessWidget {
  const CCInProgressCommandList({
    Key? key,
    required this.queryResult,
    required this.runMutation,
  }) : super(key: key);

  final QueryResult queryResult;
  final RunMutation? runMutation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Commandes à effectuer", style: Theme.of(context).textTheme.headline2,),
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
                    message: "Nous ne parvenons pas à récupérer les commandes à préparer...",
                  ),
                );
              }

              final List mapCCCommands = queryResult.data!["commerce"]["cccommands"]["edges"] as List;
              final List<CCCommand> cccommands = [];

              for (final mapCCCommand in mapCCCommands) {
                cccommands.add(CCCommand.fromJson(mapCCCommand["node"] as Map<String, dynamic>));
              }

              return _buildContent(cccommands);
            },
          ),
        )
      ],
    );
  }

  Widget _buildContent(List<CCCommand> cccommands) {
    return ListView.builder(
      itemCount: cccommands.length,
      itemBuilder: (context, index) => CCCommandCard(
        command: cccommands[index], 
        index: index + 1,
        runMutation: runMutation,
      ),
    );
  }
}