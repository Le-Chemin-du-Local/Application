import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/commerces_graphql.dart';
import 'package:chemin_du_local/features/commerces/commerces_list_page.dart/widgets/commerce_card.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/place/place_service.dart';
import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:latlng/latlng.dart';

class CommercesList extends StatelessWidget {
  const CommercesList({
    Key? key,
    required this.address
  }) : super(key: key);

  final String? address;

  QueryOptions _commercesQueryOption(LatLng userCoordinates) {
    return QueryOptions<dynamic>(
      document: gql(qCommercesMini),
      variables: <String, dynamic>{
        "nearLatitude": userCoordinates.latitude,
        "nearLongitude": userCoordinates.longitude,
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Le titre
        Row(
          children: [
            Icon(
              CLIcons.mapage,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 5,),

            Flexible(
              child: Text("Nos commerces de proximité", style: Theme.of(context).textTheme.headlineSmall,)
            ),
          ],
        ),
        const SizedBox(height: 15,),

        // La liste des commerces
        FutureBuilder(
          future: _getCoordinates(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }

            if (!snapshot.hasData) {
              return const Align(
                alignment: Alignment.topCenter,
                child: ClStatusMessage(
                  type: ClStatusMessageType.info,
                  message: "Vous devez rentrer une adresse ou votre localisation pour voir les commerces les plus proches",
                ),
              );
            }

            // return Text("Helli World");
            return Flexible(
              child: Query<dynamic>(
                options: _commercesQueryOption(snapshot.data as LatLng),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const Center(child: CircularProgressIndicator(),);
                  }

                  if (result.hasException) {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: ClStatusMessage(
                        message: "Nous ne parvenons pas à charger la liste des commerces...",
                      ),
                    );
                  }

                  final List mapCommerces = result.data!["commerces"]["edges"] as List;
                  final List<Commerce> commerces = [];

                  for (final mapCommerce in mapCommerces) {
                    commerces.add(Commerce.fromJson(mapCommerce["node"] as Map<String, dynamic>));
                  }

                  if (commerces.isEmpty) {
                    return _buildEmptyWidget();
                  }

                  return _buildContent(commerces: commerces);
                }
              )
            );
          }
        )
      ],
    );
  }

  Widget _buildContent({
    required List<Commerce> commerces
  }) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        mainAxisExtent: 348,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      primary: false,
      shrinkWrap: true,
      children: [
        for (final commerce in commerces) 
          CommerceCard(commerce: commerce)
      ],
    );
  }

  Widget _buildEmptyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.pin_drop, size: 92,),
        SizedBox(height: 12,),

        Text(
          "Il n'y a malheuresement pas de commerce proche de toi...",
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Future<LatLng?> _getCoordinates() async {
    if (address != null) {
      return PlaceAPIProvider.instance.latLgnForAddress(address!);
    }

    final locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) return null;

    // On a besoin de demander l'autorisation sur beaucoup d'appareil
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
}