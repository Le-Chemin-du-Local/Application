import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commands/panier_page/widgets/panier_command_products_card.dart';
import 'package:chemin_du_local/features/commands/widgets/command_user_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier_command.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PanierCommandPage extends StatelessWidget {
  const PanierCommandPage({
    Key? key,
    required this.panierCommandID,
    required this.runMutation,
  }) : super(key: key);

  final String panierCommandID;

  final RunMutation? runMutation;

  QueryOptions _commandDetailsQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qPanierCommandDetails),
      variables: <String, dynamic>{
        "id": panierCommandID
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Détail de la commande")),
      body: Query<dynamic>(
        options: _commandDetailsQueryOptions(),
        builder: (commandDetailsResult, {fetchMore, refetch}) {
          if (commandDetailsResult.isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }
    
          if (commandDetailsResult.hasException) {
            return const Align(
              alignment: Alignment.topCenter,
              child: ClStatusMessage(
                message: "Nous n'arrivons pas à charger les détails de cette commande",
              ),
            );
          }
    
          final PanierCommand panierCommand = PanierCommand.fromJson(commandDetailsResult.data!["paniercommand"] as Map<String, dynamic>);
    
          return _buildContent(panierCommand);
        },
      ),
    ); 
  }

  Widget _buildContent(PanierCommand command) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: ScreenHelper.horizontalPadding,
        right: ScreenHelper.horizontalPadding,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= ScreenHelper.breakpointPC) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The user info card
                Expanded(
                  flex: 35,
                  child: SingleChildScrollView(
                    child: CommandUserCard(
                      user: command.user,
                      pickupDate: command.pickupDate,
                    ),
                  ),
                ),
                const SizedBox(width: 25,),

                Expanded(
                  flex: 65,
                  child: SingleChildScrollView(
                    child: PanierCommandProductsCard(
                      command: command,
                      onMarkReady: () => _markCommandAsReady(context),
                    ),
                  ),
                )

              ],
            );
          }

          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // The user info card
                Flexible(
                  child: CommandUserCard(
                    user: command.user,
                    pickupDate: command.pickupDate,
                  ),
                ),
                const SizedBox(height: 18,),

                // The products info card
                Flexible(
                  child: PanierCommandProductsCard(
                    command: command,
                    onMarkReady: () => _markCommandAsReady(context),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }


  void _markCommandAsReady(BuildContext context) {
    if (runMutation != null) {
      runMutation!(<String, dynamic>{
        "id": panierCommandID,
        "status": PanierCommandStatus.ready
      });
    }

    Navigator.of(context).pop();
  }
}