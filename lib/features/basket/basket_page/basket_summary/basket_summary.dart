import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_summary/widgets/basket_commerce_card.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_price.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/commands/commands_graphql.dart';
import 'package:chemin_du_local/features/commands/models/command/command.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:chemin_du_local/features/commands/widgets/pending_commands_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BasketSummary extends ConsumerWidget {
  const BasketSummary({
    Key? key,
    required this.basket,
    required this.onPay,
  }) : super(key: key);

  final Basket basket;
  final Function() onPay;

  QueryOptions<dynamic> _commandsQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qGetCommandsMini),
      variables: const <String, dynamic>{
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
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isConnected = ref.read(appUserControllerProvider).token != null;

    return Column(
      children: [
        // La liste des commandes et produits
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isConnected) ...{
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
                    child: Query<dynamic>(
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
                  ),
                  const SizedBox(height: 12,)
                },
                
                // La liste des produits
                for (final commerce in basket.commerces)
                  BasketCommerceCard(commerce: commerce),
              ],
            ),
          ),
        ),

        // Le bouton
        Container(
          color: Theme.of(context).colorScheme.surface,
          padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.instance.horizontalPadding,
            vertical: 14
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Le prix
              BasketPrice(basket: basket),
              const SizedBox(height: 26,),

              ElevatedButton(
                onPressed: basket.commerces.isNotEmpty ? onPay : null, 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.shopping_basket_sharp),
                    SizedBox(width: 12,),

                    Text("Passer ma commande")
                  ],
                ),
              ),
              const SizedBox(height: 8,)
            ],
          ),
        ),
      ],
    );
  }
}