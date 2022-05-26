import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/badge.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/services.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/storekeeper_page.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class CommerceCard extends StatelessWidget {
  const CommerceCard({
    Key? key,
    required this.commerce
  }) : super(key: key);

  final Commerce commerce;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openCommercePage(context),
      child: ClCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // L'image
            Expanded(
              flex: 6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: _buildImageWithName(context),              )
            ),
            const SizedBox(height: 12,),

            Flexible(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // La localisation
                  Flexible(
                    child: _buildLocationRow(context)
                  ),
                  // const SizedBox(height: 8,),

                  // Le service de click and collect
                  if (commerce.services.contains(CommerceServices.clickAndCollect)) ...{
                    Flexible(
                      child: _buildIconRow(
                        context, 
                        icon: Icons.check, 
                        child: const Text("Click and collect")
                      ),
                    ),
                    // const SizedBox(height: 8,)
                  },

                  // Le service de click and collect
                  if (commerce.services.contains(Services.paniers)) ...{
                    Flexible(
                      child: _buildIconRow(
                        context, 
                        icon: Icons.check, 
                        child: const Text("Paniers")
                      ),
                    ),
                    // const SizedBox(height: 8,)
                  },

                  const Text("La ligne des avis")
                ]
              )
            )

          ],
        ),
      ),
    );
  }

  Widget _buildImageWithName(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            "$kImagesBaseUrl/commerces/${commerce.id}/header.jpg",
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
              ),
            ),
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.image, size: 92, color: Theme.of(context).colorScheme.outline,);
            },
          )
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0)
              )
            ),
            child: Text(
              commerce.name,
              style: const TextStyle(fontWeight: FontWeight.w500, color: Palette.colorWhite),
            )
          ),
        )
      ],
    );
  }

  Widget _buildLocationRow(BuildContext context) {
    return Row(
      children: [
        // L'adresse
        Expanded(
          flex: 7,
          child: _buildIconRow(
            context,
            icon: Icons.location_on,
            child: Text(
              (commerce.address ?? "Adresse Iconnue").replaceAll(", France", ""),
              style: const TextStyle(fontWeight: FontWeight.bold),
            )
          ),
        ),

        // La distance
        const Badge(child: Text("à 1,5 km"))
      ],
    );
  }

  Widget _buildIconRow(BuildContext context, {required IconData icon, required Widget child}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 4,),

        Flexible(child: child)
      ],
    );
  }

  Future _openCommercePage(BuildContext context) async {
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => StoreKeeperPage(storekeeperID: commerce.storekeeper?.id,)
      )
    );
  }
}