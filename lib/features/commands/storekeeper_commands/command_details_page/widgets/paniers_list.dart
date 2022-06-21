import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/models/panier/panier.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/models/panier_command/panier_command.dart';
import 'package:flutter/material.dart';

class PaniersList extends StatefulWidget {
  const PaniersList({
    Key? key,
    required this.paniers,
  }) : super(key: key);

  final List<PanierCommand> paniers;

  @override
  State<PaniersList> createState() => _PaniersListState();
}

class _PaniersListState extends State<PaniersList> {
  final List<String> _outOfStockProducts = [];

  @override
  Widget build(BuildContext context) {
    final sortedPaniers = _sortPaniers();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isBig = constraints.maxWidth >= ScreenHelper.breakpointTablet;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Le titre
            Text(
              "Paniers",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary
              ),
            ),
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 20,),

            for (final category in sortedPaniers.keys) ...{
              // Le header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 300,
                    child: Text("• $category", style: Theme.of(context).textTheme.headlineSmall,)
                  ),
                  if (isBig) ...{
                    SizedBox(
                      width: 200,
                      child: Text("Item épuisé ?", style: Theme.of(context).textTheme.headlineSmall,),
                    ),
                    SizedBox(
                      width: 60,
                      child: Text("Prix", style: Theme.of(context).textTheme.headlineSmall,),
                    ),
                  }
                ],
              ),
              const SizedBox(height: 7,),

              // Les produits
              for (final product in sortedPaniers[category]!) ...{
                if (isBig)
                  _buildBigPanierLine(product)
                else 
                  _buildSmallPanierLine(product),

                const SizedBox(height: 5,),
              }
            }
              
          ],
        );
      }
    );
  }

  Widget _buildBigPanierLine(PanierCommand panier) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Le nom du produit
        SizedBox(
          width: 300,
          child: _buildPanierName(panier)
        ),

        // La check box pour l'épuisement
        SizedBox(
          width: 200,
          child: _buildPanierOutOfStock(panier)
        ),

        SizedBox(
          width: 60,
          child: _buildPanierPrice(panier)
        )
      ],
    );
  }

  Widget _buildSmallPanierLine(PanierCommand panier) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildPanierName(panier),

        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPanierOutOfStock(panier, showText: true),
              _buildPanierPrice(panier)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildPanierName(PanierCommand panier) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // La quantité
        Container(
          width: 30, height: 30,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(4)
          ),
          child: Center(
            child: Text(
              "1",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 4,),

        Text(panier.panier.name, style: Theme.of(context).textTheme.titleMedium,),
      ],
    );
  }

  Widget _buildPanierOutOfStock(PanierCommand panier, { bool showText = false }) {
    return ClCheckBox(
      value: _outOfStockProducts.contains(panier.panier.id), 
      text: showText ? "Produit épuisé ?" : "",
      onChanged: (value) {
        if ((value ?? false) && panier.panier.id != null) {
          setState(() {
            _outOfStockProducts.add(panier.panier.id!);
          });
        }
        else if (panier.panier.id != null) {
          setState(() {
            _outOfStockProducts.remove(panier.panier.id);
          });
        }
      }, 
    );
  }

  Widget _buildPanierPrice(PanierCommand panier) {
    return Text("${(panier.panier.price).toStringAsFixed(2)}€", style: Theme.of(context).textTheme.titleMedium,);
  }

  Map<String, List<PanierCommand>> _sortPaniers() {
    final Map<String, List<PanierCommand>> sorted = {
      "Paniers permanents": [],
      "Paniers flash": []
    };


    for (final panier in widget.paniers) {
      if (panier.panier.type == PanierType.permanent) {
        sorted["Paniers permanents"]!.add(panier);
      }
      else {
        sorted["Paniers flash"]!.add(panier);
      }
    }
    
    return sorted;
  }
}