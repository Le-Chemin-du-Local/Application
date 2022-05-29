import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:latlng/latlng.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key? key, 
    this.initialLatLgn,
    required this.phone,
    required this.email, 
    required this.address,
    required this.facebook,
    required this.twitter,
    required this.instagram
  }) : super(key: key);

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
                        const Flexible(child: Text("Coordonnées", style: TextStyle(fontWeight: FontWeight.bold),)),
                        const SizedBox(height: 4,),
                        Flexible(child: Text(phone)),
                        const SizedBox(height: 4,),
                        Flexible(child: Text(email))
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
                      const Flexible(child: Text("Adresse", style: TextStyle(fontWeight: FontWeight.bold),)),
                      const SizedBox(height: 4,),
                      Flexible(child: Text(address))
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
            onPressed: () {}, 
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              FontAwesome.facebook_f,
              size: 32,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

        // Logo Twitter
        if (twitter.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              FontAwesome.twitter,
              size: 32,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),

        // Logo Instagram
        if (instagram.isNotEmpty) 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              FontAwesome.instagram,
              size: 32,
              color: Theme.of(context).colorScheme.secondary,
            ),
          )
      ],
    );
  }
}