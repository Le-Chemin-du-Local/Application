import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:flutter/material.dart';

class CommerceInfoCard extends StatelessWidget {
  const CommerceInfoCard({
    Key? key, 
    required this.commerce
  }) : super(key: key);
  
  final Commerce commerce;
  
  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Le titre
          Text(
            "Informations sur le commerce", 
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 4,),

          // Le nom du commerce
          Text(commerce.name),
          const SizedBox(height: 4,),
          
          // L'adresse du commerce
          Text(commerce.address?.detailled ?? "Adresse inconnue"),
          const SizedBox(height: 4,),

          // Le téléphone du commerce
          Text(commerce.phone ?? "Pas du numéro de téléphone"),
          const SizedBox(height: 4,),
        ],
      ),
    );
  }
}