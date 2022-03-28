import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PanierCard extends StatelessWidget {
  const PanierCard({
    Key? key,
    required this.panier,
    required this.onOpen,
  }) : super(key: key);

  final Panier panier;
  final Function() onOpen;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isBig = constraints.maxWidth >= 400;

          List<Widget> children = [
            // L'image
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: isBig ? double.infinity : 300),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    "$kImagesBaseUrl/paniers/${panier.id ?? ""}.jpg",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                      ),
                    ),
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image, size: 92, color: Theme.of(context).dividerColor,);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8,),

            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Le titre
                  Text(panier.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 8,),

                  // La description
                  Text(panier.description),
                  const SizedBox(height: 30,),

                  ClElevatedButton(
                    onPressed: onOpen,
                    child: const Text("Voir le panier"),
                  )
                ],
              ),
            )
          ];

          if (isBig) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            );  
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          );
        }
      ),
    );
  }
}