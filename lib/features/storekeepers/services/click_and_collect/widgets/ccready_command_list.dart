import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/cccommand.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/widgets/cccommand_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CCReadyCommandList extends StatelessWidget {
  const CCReadyCommandList({
    Key? key,
    required this.queryResult,
    required this.runMutation,
  }) : super(key: key);

  final QueryResult<dynamic> queryResult;

  final RunMutation? runMutation;

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
      itemBuilder: (context, index) => Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: CCCommandCard(
              command: cccommands[index], 
              index: index + 1,
              runMutation: null,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClFloatingButton(
              icon: Icons.check,
              onPressed: () => _markCommandAsDone(cccommands[index].id!),
            ),
          )
        ],
      ),
    );
  }

  void _markCommandAsDone(String cccommandId) {
    if (runMutation != null) {
      runMutation!(<String, dynamic>{
        "id": cccommandId,
        "status": CCCommandStatus.done
      });
    }
  }
}