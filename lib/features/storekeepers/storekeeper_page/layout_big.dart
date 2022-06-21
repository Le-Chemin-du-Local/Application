import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/address_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/business_hours_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/paniers_list.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';

class LayoutBig extends StatelessWidget {
  const LayoutBig({
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
        const SizedBox(height: 316,),

        // Les deux colonnes principales
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.instance.horizontalPadding
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Première colonne
              Flexible(
                flex: 55,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Description du commerce
                    ClCard(
                      child: Opacity(
                        opacity: (commerce?.description ?? "").isEmpty ? 0.4 : 1.0,
                        child: Text(commerce?.description ?? "Pas de description"),
                      ),
                    ),
                    const SizedBox(height: 20,),
              
                    // Les produits
                    Flexible(
                      child: ProductsGrid(
                        enableButton: false,
                        commerce: commerce,
                        products: products,
                        availableForClickAndCollect: [
                          for (final product in productsAvailableForClickAndCollect)
                              product.id!
                          ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12,),

              // La deuxième colonne
              Flexible(
                flex: 45,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Les horaires
                    BusinessHoursCard(businessHours: commerce?.businessHours),
                    const SizedBox(height: 10,),

                    // Les coordonnées
                    Flexible(
                      child: AddressCard(
                        initialLatLgn: commerceLatLgn,
                        address: commerce?.address?.detailled ?? "Pas d'adress",
                        email: commerce?.email ?? "",
                        phone: commerce?.phone ?? "",
                        facebook: commerce?.facebook ?? "",
                        twitter: commerce?.twitter ?? "",
                        instagram: commerce?.instagram ?? "",
                      ),
                    ),
                    const SizedBox(height: 10,),
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 18,),

        // La liste des paniers
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 450),
            child: PaniersList(
              commerce: commerce,
            ),
          ),
        )

      ],
    );
  }
}