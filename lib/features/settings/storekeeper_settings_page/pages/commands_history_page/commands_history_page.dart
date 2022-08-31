import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dropdown.dart';
import 'package:chemin_du_local/features/commands/commerce_command_details_page/commerce_command_details_page.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

class CommandsHistroyPage extends StatefulWidget {
  const CommandsHistroyPage({Key? key}) : super(key: key);

  @override
  State<CommandsHistroyPage> createState() => _CommandsHistroyPageState();
}

class _CommandsHistroyPageState extends State<CommandsHistroyPage> {
  late int _selectedYear;
  int _selectedMonth = 0;

  QueryOptions _commandsOption() {
    return QueryOptions<dynamic>(
      document: gql(r'''
      query GetCommandsForCommerce(
        $year: Int!,
        $month: Int
      ) {
        commerceCommands(
          filter: {
            status: "DONE",
            year: $year,
            month: $month,
          }
        ) {
          edges {
            node {
              id
              commerce {
                id
                name
                address {
                  number
                  route
                  optionalRoute
                  postalCode
                  city
                }
                phone
              }
              price
              cccommands {
                id
                products {
                  quantity
                  product {
                    id
                    name
                    price
                  }
                }
              }
              user {
                id
                role 
                email
                firstName
                lastName
              }
              status
              pickupDate
            }
          }
        }
      }
      '''),
      variables: <String, dynamic>{
        "year": _selectedYear,
        "month": _selectedMonth == 0 ? null : _selectedMonth
      }
    );
  }

  @override
  void initState() {
    super.initState();

    _selectedYear = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: const Text("Historique des commandes"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenHelper.instance.horizontalPadding
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Les sélécteur
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ClDropdown<int>(
                      currentValue: _selectedYear,
                      items: <int, String>{
                        2022: "2022",
                        for (int value = 2022; value < DateTime.now().year; ++value)
                          value: value.toString()
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedYear = value!;
                          _selectedMonth = 0;
                        });
                      },
                      validator: null,
                    ),
                  ),
                  const SizedBox(width: 4,),
                  Flexible(
                    child: ClDropdown<int>(
                      currentValue: _selectedMonth,
                      items: <int, String>{
                        0: "Tous les mois",
                        for (int month = 1; month < 13; ++month)
                          month: DateFormat("MMMM").format(DateTime(2022, month))
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedMonth = value!;
                        });
                      },
                      validator: null,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16,),

            // Les commandes
            Expanded(
              child: Query<dynamic>(
                options: _commandsOption(),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const Center(child: CircularProgressIndicator(),);
                  }

                  if (result.hasException) {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: ClStatusMessage(
                        message: "Impossible de charger l'historique des commandes",
                      ),
                    );
                  }

                  final List mapCommands = result.data!["commerceCommands"]["edges"] as List;
                  final List<CommerceCommand> commands = [];

                  for (final mapCommand in mapCommands) {
                    commands.add(CommerceCommand.fromJson(mapCommand["node"] as Map<String, dynamic>));
                  }

                  if (commands.isEmpty) {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: ClStatusMessage(
                        type: ClStatusMessageType.info,
                        message: "Vous n'avez pas de commande pour cette période.",
                      ),
                    );
                  }

                  final sortedCommands = _sortCommands(commands);

                  return ListView(
                    shrinkWrap: true,
                    children: [
                      for (final month in sortedCommands.keys) ...{
                        // Le mois et prix total
                        Text(
                          "${DateFormat("MMMM").format(month)} - ${_totalPriceForCommands(sortedCommands[month]!).toStringAsFixed(2)}€",
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 12,),

                        // Les cartes des commandes
                        for (final command in sortedCommands[month]!)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: InkWell(
                              onTap: () => _openDetailsPage(context, command),
                              child: ClCard(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Commande du ${DateFormat("dd/MM/yyyy").format(command.pickupDate!)}",
                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 4,),
                                        const Icon(Icons.arrow_forward_ios, size: 12,)
                                      ],
                                    ),
                                    const SizedBox(height: 8,),
                            
                                    Flexible(
                                      child: RichText(
                                        text: TextSpan(
                                          style: Theme.of(context).textTheme.bodyMedium,
                                          children: [
                                            TextSpan(
                                              text: "${command.user?.firstName ?? "Inconnu"} ${command.user?.lastName ?? "Inconnu"} - "
                                            ),
                                            TextSpan(
                                              style: const TextStyle(fontWeight: FontWeight.w500),
                                              text: "${(command.price ?? 0).toStringAsFixed(2)}€"
                                            )
                                          ]
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )      
                      },
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _openDetailsPage(BuildContext context, CommerceCommand command) async {
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => CommerceCommandDetailsPage(commerceCommand: command)
      )
    );
  }

  Map<DateTime, List<CommerceCommand>> _sortCommands(List<CommerceCommand> commands) {
    final Map<DateTime, List<CommerceCommand>> result = {};

    for (final command in commands) {
      if (command.pickupDate == null) continue;

      final DateTime commandMonth = DateTime(command.pickupDate!.year, command.pickupDate!.month);

      if (result.containsKey(commandMonth)) {
        result[commandMonth]!.add(command);
      }
      else {
        result[commandMonth] = [
          command
        ];
      }
    }

    return result;
  }
  
  double _totalPriceForCommands(List<CommerceCommand> commands) {
    double result = 0.0;

    for (final command in commands) {
      result += command.price ?? 0.0;
    }
    
    return result;
  }
}