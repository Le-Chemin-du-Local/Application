import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_map.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/gradient_icon.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/commerces/commerces_graphql.dart';
import 'package:chemin_du_local/features/commerces/commerces_list_page.dart/widgets/commerce_card.dart';
import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:latlng/latlng.dart';

class CommercesList extends StatelessWidget {
  const CommercesList({
    Key? key,
    required this.userCoordinated
  }) : super(key: key);

  final LatLng userCoordinated;

  QueryOptions _commercesQueryOption() {
    return QueryOptions<dynamic>(
      document: gql(qCommercesMini),
      variables: <String, dynamic>{
        "nearLatitude": userCoordinated.latitude,
        "nearLongitude": userCoordinated.longitude,
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Query<dynamic>(
      options: _commercesQueryOption(),
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
      },
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

  Widget _buildContent({
    required List<Commerce> commerces
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isBig = constraints.maxWidth >= ScreenHelper.breakpointPC;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,    
                  children: [
                    // Le titre
                    Text("10 commerces", style: Theme.of(context).textTheme.headline2,),
                    const SizedBox(height: 12,),
            
                    // La carte (affiché uniquement sur petit écran)
                    if (!isBig) ...{
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: _buildMap(commerces: commerces)
                      ),
                      const SizedBox(height: 12,),
                    },

                    // Le titre commerce de proximité
                    Flexible(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          GradientIcon(CLIcons.mapage, gradient: Palette.gradientPrimary),
                          SizedBox(width: 4,),
                          Text("Découvrez nos commerces de proximité")
                        ],
                      ),
                    ),
                    const SizedBox(height: 12,),

                    Expanded(
                      child: _buildList(commerces: commerces),
                    ),
                    // La liste des commerces
                  ],
                ),
              ),
            ),

            // La carte (affiché uniquement sur grand écran)
            if (isBig)
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(12.0)),
                  child: _buildMap(commerces: commerces)
                )
              )
          ],
        );
      }
    );
  }

  Widget _buildList({
    required List<Commerce> commerces
  }) {
    return GridView(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        mainAxisExtent: 200,
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

  Widget _buildMap({
    required List<Commerce> commerces
  }) {
    return ClMap(
      initialLatLgn: userCoordinated,
      initialZoom: 12,
      markers: [
        for (final commerce in commerces) 
          LatLng(commerce.latitude!, commerce.longitude!)
      ],
    );
  }
}