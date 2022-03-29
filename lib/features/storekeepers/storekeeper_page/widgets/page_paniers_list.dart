import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_panier_card.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PagePaniersList extends StatelessWidget {
  const PagePaniersList({
    Key? key,
    required this.commerceID,
  }) : super(key: key);

  final String? commerceID;

  QueryOptions _paniersQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qAllPaniers),
      variables: <String, dynamic>{
        "commerceID": commerceID
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Headline
        const Flexible(
          child: Text(
            "Sinon laissez vous tenter par nos paniers", 
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20,),

        // La liste des paniers
        if (commerceID == null) 
          const ClStatusMessage(
            type: ClStatusMessageType.info,
            message: "Ce commerce ne propose pas encore de panier",
          )
        else 
          Flexible(
            child: Query<dynamic>(
              options: _paniersQueryOptions(),
              builder: (result, {fetchMore, refetch}) {
                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator(),);
                }
          
                if (result.hasException) {
                  return const ClStatusMessage(
                    message: "Nous ne parvenons pas à charger les paniers",
                  );
                }
          
                final List mapPaniers = result.data!["commerce"]["paniers"]["edges"] as List;
                final List<Panier> paniers = [];
          
                for (final mapPanier in mapPaniers) {
                  paniers.add(Panier.fromJson(mapPanier["node"] as Map<String, dynamic>));
                }
          
                return ListView(
                  controller: ScrollController(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (final panier in paniers) 
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 720),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: PagePanierCard(
                            panier: panier,
                            onOpen: () {},
                          ),
                        ),
                      )
                  ],
                );
              },
            ),
          )
      ],
    );
  }
}