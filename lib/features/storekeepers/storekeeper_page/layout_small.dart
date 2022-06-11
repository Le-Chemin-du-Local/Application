import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/address_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/business_hours_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/paniers_list.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/products_list.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';

class LayoutSmall extends StatelessWidget {
  const LayoutSmall({
    Key? key,
    required this.commerce,
    required this.products,
    required this.productsAvailableForClickAndCollect
  }) : super(key: key);

  final Commerce? commerce;
  final List<Product> products;
  final List<Product> productsAvailableForClickAndCollect;

  @override
  Widget build(BuildContext context) {
    LatLng? commerceLatLgn;

    if (commerce != null && commerce!.latitude != null && commerce!.longitude != null) {
      commerceLatLgn = LatLng(commerce!.latitude!, commerce!.longitude!);      
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // L'espace du header
        const SizedBox(height: 316,),

        // Les horaires
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenHelper.instance.horizontalPadding,
              vertical: 5
            ),
            child: BusinessHoursCard(
              businessHours: commerce?.businessHours,
            ),
          ),
        ),

        // Les coordonnées
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenHelper.instance.horizontalPadding,
              vertical: 5
            ),
            child: AddressCard(
              initialLatLgn: commerceLatLgn,
              phone: commerce?.phone ?? "",
              email: commerce?.email ?? "",
              address: commerce?.address?.detailled ?? "",
              facebook: commerce?.facebook ?? "",
              twitter: commerce?.twitter ?? "",
              instagram: commerce?.instagram ?? "",
            ),
          ),
        ),
        const SizedBox(height: 10,),

        // La description
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.instance.horizontalPadding,
            vertical: 5
          ),
          child: ClCard(
            child: Opacity(
              opacity: (commerce?.description ?? "").isEmpty ? 0.4 : 1.0,
              child: Text(commerce?.description ?? "Pas de description"),
            ),
          ),
        ),

        // La liste des produits
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: ProductsList(
                commerce: commerce,
                products: products, 
                availableForClickAndCollect: [
                  for (final product in productsAvailableForClickAndCollect)
                    product.id!
                ],
                enableButton: false,
              ),
            ),
          ),
        ),

        // La liste des paniers
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 450),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5
              ),
              child: PaniersList(
                commerce: commerce,
              ),
            ),
          ),
        ),
      ],
    );
  }
}