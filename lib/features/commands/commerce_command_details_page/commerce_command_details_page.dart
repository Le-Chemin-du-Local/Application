import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commands/commands_graphql.dart';
import 'package:chemin_du_local/features/commands/commerce_command_details_page/widgets/commerce_command_summary_card.dart';
import 'package:chemin_du_local/features/commands/commerce_command_details_page/widgets/commerce_info_card.dart';
import 'package:chemin_du_local/features/commands/commerce_command_details_page/widgets/validation_button.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommerceCommandDetailsPage extends StatelessWidget {
  const CommerceCommandDetailsPage({
    Key? key,
    required this.commerceCommand,
    required this.commandIndex,
  }) : super(key: key);

  final CommerceCommand commerceCommand;
  final int commandIndex;

  MutationOptions _updateCommerceCommandMutationOptions(BuildContext context) {
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
      appBar: AppBar(
        title: Text("Adresse $commandIndex"),
      ),
      body: Mutation<dynamic>(
        options: _updateCommerceCommandMutationOptions(context),
        builder: (runMutation, mutationResult) {
          if (mutationResult?.isLoading ?? false) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              Positioned.fill(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: ScreenHelper.instance.horizontalPadding
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Message d'erreur si nécessaire
                        if (mutationResult?.hasException ?? false) ...{
                          const ClStatusMessage(
                            message: "Impossible de valider la commande. Vérifier votre connexion internet",
                          ),
                          const SizedBox(height: 12),
                        },
              
                        // Text descriptif
                        const Text("Présentez-vous au commerce au créneau de collecte indiqué en lui présentant la carte associée à l’adresse. Il validera ce reçu et vous pourrez repartir avec les produits de votre commerçant préféré 😉"),
                        const SizedBox(height: 24,),
              
                        // Le recapitluatif
                        CommerceCommandSummaryCard(command: commerceCommand),
                        const SizedBox(height: 12,),
              
                        // Les infos sur le commerce
                        if (commerceCommand.commerce != null) ...{
                          CommerceInfoCard(commerce: commerceCommand.commerce!),
                          const SizedBox(height: 64,),
                        },
                      ],
                    ),
                  ),
                ),
              ),
              // Le bouton de validation
              Positioned(
                bottom: 28,
                left: ScreenHelper.instance.horizontalPadding,
                right: ScreenHelper.instance.horizontalPadding,
                child: ValidationButton(
                  onValidate: commerceCommand.status == CommandStatus.ready 
                    ? () => _onValidate(runMutation)
                    : null
                ),
              )
            ],
          );
        }
      )
    );
  }

  void _onValidate(RunMutation? runMutation) {
    if (runMutation != null) {
      runMutation(<String, dynamic>{
        "id": commerceCommand.id,
        "changes": {
          "status": CommandStatus.done
        }
      });
    }
  }
}