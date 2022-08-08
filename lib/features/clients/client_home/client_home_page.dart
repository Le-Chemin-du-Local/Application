import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_address_input.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/clients/client_home/widgets/commerces_list.dart';
import 'package:chemin_du_local/features/commands/commands_graphql.dart';
import 'package:chemin_du_local/features/commands/models/command/command.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:chemin_du_local/features/commands/widgets/pending_commands_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ClientHomePage extends ConsumerStatefulWidget {
  const ClientHomePage({
    Key? key,
    required this.onShowDrawer,
  }) : super(key: key);

  final Function() onShowDrawer;

  @override
  ConsumerState<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends ConsumerState<ClientHomePage> {
  final TextEditingController _addressTextController = TextEditingController();

  String? _address;


  QueryOptions<dynamic> _commandsQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qGetCommandsMini),
      variables: <String, dynamic>{
        "filter": {
          "status": [
            CommandStatus.inProgress,
            CommandStatus.ready
          ]
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        onShowDrawer: widget.onShowDrawer,
        canPop: false,
        title: const Text("Bienvenue, Victor 👋"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.instance.horizontalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // La barre d'adresse
              ClAddressInput(
                label: "",
                hint: "Où êtes vous en ce moment ?",
                addressTextController: _addressTextController,
                onSelected: _onAddressSelected,
              ),
              const SizedBox(height: 15,),
              
              // Les commandes en cours
              if (ref.watch(appUserControllerProvider).token != null) ...{
                Query<dynamic>(
                  options: _commandsQueryOptions(),
                  builder: (result, {fetchMore, refetch}) {
                    if (result.isLoading) {
                      return const Center(child: CircularProgressIndicator(),);
                    }

                    if (result.hasException) {
                      return const ClStatusMessage(
                        message: "Nous n'arrivons pas à charger vos commandes...",
                      );
                    }

                    final List mapCommands = result.data!["commands"]["edges"] as List;
                    final List<Command> commands = [];

                    for (final mapCommand in mapCommands) {
                      commands.add(Command.fromJson(mapCommand["node"] as Map<String, dynamic>));
                    }

                    if (commands.isNotEmpty) {
                      return PendingCommandsCard(commandsCount: commands.length);
                    }

                    return Container();
                  },
                ),
                const SizedBox(height: 15,),
              },

              // La liste des commerce
              Flexible(
                child: CommercesList(address: _address),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onAddressSelected(String address) {
    setState(() {
      _address = address;
    });
  }
}