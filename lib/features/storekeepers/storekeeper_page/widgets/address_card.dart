import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:latlng/latlng.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key? key, 
    this.initialLatLgn,
    required this.onShowMap,
    required this.phone,
    required this.email, 
    required this.address,
    required this.facebook,
    required this.twitter,
    required this.instagram
  }) : super(key: key);

  final Function() onShowMap;

  final LatLng? initialLatLgn;

  final String phone;
  final String email;
  final String address;

  final String facebook;
  final String twitter;
  final String instagram;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // La carte 
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: ClMap(
                initialLatLgn: initialLatLgn,
                showInitialLatLgnMarker: true,
              ),
            ),
          ),
          const SizedBox(height: 12,),
    
          // Les coordonnées
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // La colonne de téléphone et email
                Expanded(
                  child: Container(
                    // On ajoute la bordure sur cette colonne
                    padding: const EdgeInsets.only(right: 24),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Theme.of(context).colorScheme.outline,
                          width: 0.5
                        )
                      )
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(child: Text("Coordonnées", style: Theme.of(context).textTheme.titleMedium,)),
                        const SizedBox(height: 4,),
                        Flexible(
                          child: Text(
                            phone, 
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w300
                            ),
                          )
                        ),
                        const SizedBox(height: 4,),
                        Flexible(
                          child: Text(
                            email, 
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w300
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24,),
          
                // La colonne d'adresse
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(child: Text("Adresse", style: Theme.of(context).textTheme.titleMedium,)),
                      const SizedBox(height: 4,),
                      Flexible(
                        child: Text(
                          address,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w300
                          ),
                        )
                      )
                    ], 
                  )
                )
              ],
            ),
          ),
          const SizedBox(height: 20,),
    
          // Les réseaux sociaux
          Flexible(child: _buildSocialNetworksIcons(context),),
          const SizedBox(height: 18,),

          // Le bouton d'intinéraire
          ElevatedButton(
            onPressed: onShowMap, 
            child: const Text("Voir l'itinéraire")
          ),
        ],
      ),
    );
  }


  Widget _buildSocialNetworksIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo Facebook
        if (facebook.isNotEmpty)
          InkWell(
            onTap: () => launchUrlString(facebook, mode: LaunchMode.externalApplication),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                FontAwesome.facebook_f,
                size: 32,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),

        // Logo Twitter
        if (twitter.isNotEmpty)
          InkWell(
            onTap: () => launchUrlString(twitter, mode: LaunchMode.externalApplication),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                FontAwesome.twitter,
                size: 32,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),

        // Logo Instagram
        if (instagram.isNotEmpty) 
          InkWell(
            onTap: () => launchUrlString(instagram, mode: LaunchMode.externalApplication),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                FontAwesome.instagram,
                size: 32,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          )
      ],
    );
  }
}