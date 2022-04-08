import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/cccommand.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/click_and_collect_grahpql.dart';
import 'package:chemin_du_local/features/commands/widgets/in_progress_command_list.dart';
import 'package:chemin_du_local/features/commands/widgets/ready_command_list.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier_command.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CommandsPage extends StatefulWidget {
  const CommandsPage({Key? key}) : super(key: key);

  @override
  State<CommandsPage> createState() => _CommandsPageState();
}

class _CommandsPageState extends State<CommandsPage> {
  String _errorMessage = "";

  bool _shouldRefetch = false;

  QueryOptions _cccommandOptions(String status) {
    return QueryOptions<dynamic>(
      document: gql(qCCCommandsMini),
      variables: <String, dynamic>{
        "status": status
      }
    );
  }

  QueryOptions _panierCommandsOptions(String status) {
    return QueryOptions<dynamic>(
      document: gql(qPanierCommandsMini),
      variables: <String, dynamic>{
        "status": status
      }
    );
  }

  MutationOptions _cccUpdateCommandMutationOption() {
    return MutationOptions<dynamic>(
      document: gql(mutUpdateCCCommand),
      onError: (error) {
        _errorMessage = "Nous n'avons pas pu mettre à jour les commandes... Veuillez vérifier votre connexion internet et réessayer.";
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        _errorMessage = "";
        _shouldRefetch = true;
      }
    ); 
  }

  MutationOptions _panierUpdateCommandMutationOption() {
    return MutationOptions<dynamic>(
      document: gql(mutUpdatePanierCommand),
      onError: (error) {
        _errorMessage = "Nous n'avons pas pu mettre à jour les commandes... Veuillez vérifier votre connexion internet et réessayer.";
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        _errorMessage = "";
        _shouldRefetch = true;
      }
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The first query is for the ready ones
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: ScreenHelper.horizontalPadding,
          right: ScreenHelper.horizontalPadding,
        ),
        child: Mutation<dynamic>(
          options: _cccUpdateCommandMutationOption(),
          builder: (runMutation, mutationResult) {
            if (mutationResult?.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator(),);
            }

            return Mutation<dynamic>(
              options: _panierUpdateCommandMutationOption(),
              builder: (runPanierMutation, panierMutationResult) {
                return Query<dynamic>(
                  options: _cccommandOptions(CCCommandStatus.ready),
                  builder: (readyCommandResult, {fetchMore, refetch}) {
                    if (_shouldRefetch) {
                      if (refetch != null) refetch();
                    }

                    return Query<dynamic>(
                      options: _cccommandOptions(CCCommandStatus.inProgress),
                      builder: (inProgressCommandResult, {fetchMore, refetch}) {
                        if (_shouldRefetch) {
                          if (refetch != null) refetch();
                        }

                        return Query<dynamic>(
                          options: _panierCommandsOptions(PanierCommandStatus.ready),
                          builder: (readyPanierCommandResult, {fetchMore, refetch}) {
                            if (_shouldRefetch) {
                              if (refetch != null) refetch();
                            }

                            return Query<dynamic>(
                              options: _panierCommandsOptions(PanierCommandStatus.inProgress),
                              builder: (inProgressPanierCommandResult, {fetchMore, refetch}) {
                                if (_shouldRefetch) {
                                  if (refetch != null) refetch();

                                  _shouldRefetch = false;
                                }

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    if (_errorMessage.isNotEmpty) ...{
                                      ClStatusMessage(
                                        message: _errorMessage,
                                      ),
                                      const SizedBox(height: 12,),
                                    },
                                    Flexible(
                                      child: LayoutBuilder(
                                        builder: (context, constraints) {
                                          final bool useBigLayout = constraints.maxWidth > ScreenHelper.breakpointPC;
                                    
                                          if (useBigLayout) {
                                            return _buildBigLayout(
                                              inProgressCommandResult: inProgressCommandResult,
                                              readyCommandResult: readyCommandResult,
                                              inProgressPanierCommandResult: inProgressPanierCommandResult,
                                              readyPanierCommandResult: readyPanierCommandResult,
                                              runMutation: runMutation,
                                              runPanierMutation: runPanierMutation
                                            );  
                                          }
                                    
                                          return _buildSmallLayout(
                                            inProgressCommandResult: inProgressCommandResult,
                                            readyCommandResult: readyCommandResult,
                                            inProgressPanierCommandResult: inProgressPanierCommandResult,
                                            readyPanierCommandResult: readyPanierCommandResult,
                                            runMutation: runMutation,
                                            runPanierMutation: runPanierMutation
                                          );   
                                        }
                                      ),
                                    ),
                                  ],
                                );
                              }
                            );
                          }
                        );
                      },
                    );
                  },
                );
              }
            );
          }
        ),
      ),
    );
  }

  Widget _buildBigLayout({
    required QueryResult inProgressCommandResult,
    required QueryResult readyCommandResult,
    required QueryResult inProgressPanierCommandResult,
    required QueryResult readyPanierCommandResult,
    required RunMutation? runMutation,
    required RunMutation? runPanierMutation,
  }) {
    return Row(
      children: [
        Flexible(
          child: InProgressCommandList(
            queryResult: inProgressCommandResult,
            panierQueryResult: inProgressPanierCommandResult,
            runMutation: runMutation,
            runPanierMutation: runPanierMutation,
          ),
        ),
        const SizedBox(width: 18,),

        // List of ready commands
        Flexible(
          child: ReadyCommandList(
            queryResult: readyCommandResult,
            panierQueryResult: readyPanierCommandResult,
            runMutation: runMutation,
            runPanierMutation: runPanierMutation,
          ),
        )
      ],
    );
  }

  Widget _buildSmallLayout({
    required QueryResult inProgressCommandResult,
    required QueryResult readyCommandResult,
    required QueryResult inProgressPanierCommandResult,
    required QueryResult readyPanierCommandResult,
    required RunMutation? runMutation,
    required RunMutation? runPanierMutation,
  }) {
     return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: InProgressCommandList(
            queryResult: inProgressCommandResult,
            panierQueryResult: inProgressPanierCommandResult,
            runMutation: runMutation,
            runPanierMutation: runPanierMutation,
          ),
        ),
        const SizedBox(width: 18,),

        // List of ready commands
        Flexible(
          child: ReadyCommandList(
            queryResult: readyCommandResult,
            panierQueryResult: readyPanierCommandResult,
            runMutation: runMutation,
            runPanierMutation: runPanierMutation,
          ),
        )
      ],
    );
  }
}