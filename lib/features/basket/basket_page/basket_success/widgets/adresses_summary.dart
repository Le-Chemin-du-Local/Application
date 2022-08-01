import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/basket/models/basket_commerce/basket_commerce.dart';
import 'package:chemin_du_local/features/commerces/commerces_graphql.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class AddressesSummary extends StatelessWidget {
  const AddressesSummary({
    Key? key,
    required this.basket
  }) : super(key: key);

  final Basket basket;

  QueryOptions _getCommerceInfoOptions(String commerceID) {
    return QueryOptions<dynamic>(
      document: gql(qCommerceMini),
      variables: <String, dynamic>{
        "id": commerceID,
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Le titre
          Flexible(
            child: Text(
              "Adresses de retrait",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          const SizedBox(height: 18,),

          for (final basketCommerce in basket.commerces) ...{
            Flexible(
              child: Query<dynamic>(
                options: _getCommerceInfoOptions(basketCommerce.commerceID),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const Center(child: CircularProgressIndicator(),);
                  }

                  if (result.hasException) {
                    return const ClStatusMessage(
                      message: "Impossible de charger les informations du commerce",
                    );
                  }

                  final Commerce commerce = Commerce.fromJson(result.data!["commerce"] as Map<String, dynamic>);
                  final pickupDateString = basketCommerce.pickupDate != null
                    ? "${DateFormat("dd/MM/yyyy").format(basketCommerce.pickupDate!)} -> ${DateFormat("hh:mm").format(basketCommerce.pickupDate!)} - ${DateFormat("hh:mm").format(basketCommerce.pickupDate!.add(const Duration(minutes: 30)))}"
                    : "Inconnue";

                  return Row(
                    children: [
                      // Les infos du commerce
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Le nom du commerce
                            Flexible(
                              child: Text(
                                commerce.name,
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4,),
                      
                            // L'adresse
                            Flexible(
                              child: Text(commerce.address?.detailled ?? "Adresse Inconnue"),
                            ),
                            
                            // La date de collecte
                            Flexible(
                              child: Text(
                                "Collecte : $pickupDateString"
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8,),

                      // Le bouton d'ajout au calendrier
                      IconButton(
                        onPressed: () => _addPickupToCalendar(basketCommerce, commerce), 
                        color: Theme.of(context).colorScheme.primary,
                        icon: const Icon(Icons.calendar_today)
                      )
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 16,),
          }
        ],
      ),
    );
  }

  void _addPickupToCalendar(BasketCommerce basketCommerce, Commerce commerce) {
    final Event event = Event(
      title: 'Commande ${commerce.name}',
      description: 'Récupération de la commande chez ${commerce.name}',
      location: commerce.address?.detailled ?? "Iconnue",
      startDate: basketCommerce.pickupDate ?? DateTime.now(),
      endDate: (basketCommerce.pickupDate ?? DateTime.now()).add(const Duration(minutes: 30)),
      iosParams: const IOSParams( 
        reminder: Duration(hours: 1), // on iOS, you can set alarm notification after your event.
      ),
      androidParams: const AndroidParams( 
        emailInvites: [], // on Android, you can add invite emails to your event.
      ),
    );
      
    Add2Calendar.addEvent2Cal(event);
  }
}