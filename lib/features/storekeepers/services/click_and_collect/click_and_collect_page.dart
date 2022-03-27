import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/cccommand.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/click_and_collect_grahpql.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/widgets/ccin_progress_command_list.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/widgets/ccready_command_list.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ClickAndCollectPage extends StatefulWidget {
  const ClickAndCollectPage({Key? key}) : super(key: key);

  @override
  State<ClickAndCollectPage> createState() => _ClickAndCollectPageState();
}

class _ClickAndCollectPageState extends State<ClickAndCollectPage> {
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
                                  runMutation: runMutation,
                                );  
                              }
                        
                              return _buildSmallLayout(
                                inProgressCommandResult: inProgressCommandResult,
                                readyCommandResult: readyCommandResult,
                                runMutation: runMutation,
                              );   
                            }
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          }
        ),
      ),
    );
  }

  Widget _buildBigLayout({
    required QueryResult inProgressCommandResult,
    required QueryResult readyCommandResult,
    required RunMutation? runMutation,
  }) {
    return Row(
      children: [
        Flexible(
          child: CCInProgressCommandList(
            queryResult: inProgressCommandResult,
            runMutation: runMutation,
          ),
        ),
        const SizedBox(width: 18,),

        // List of ready commands
        Flexible(
          child: CCReadyCommandList(
            queryResult: readyCommandResult,
            runMutation: runMutation,
          ),
        )
      ],
    );
  }

  Widget _buildSmallLayout({
    required QueryResult inProgressCommandResult,
    required QueryResult readyCommandResult,
    required RunMutation? runMutation,
  }) {
     return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: CCInProgressCommandList(
            queryResult: inProgressCommandResult,
            runMutation: runMutation,
          ),
        ),
        const SizedBox(width: 18,),

        // List of ready commands
        Flexible(
          child: CCReadyCommandList(
            queryResult: readyCommandResult,
            runMutation: runMutation,
          ),
        )
      ],
    );
  }
}