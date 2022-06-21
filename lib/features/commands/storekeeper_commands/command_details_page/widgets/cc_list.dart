import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/models/cccommand/cccommand.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/models/ccproduct/ccproduct.dart';
import 'package:flutter/material.dart';

class CCList extends StatefulWidget {
  const CCList({
    Key? key,
    required this.command
  }) : super(key: key);

  final CCCommand command;

  @override
  State<CCList> createState() => _CCListState();
}

class _CCListState extends State<CCList> {
  final List<String> _outOfStockProducts = [];

  @override
  Widget build(BuildContext context) {
    final products = _sortProducts();

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isBig = constraints.maxWidth >= ScreenHelper.breakpointTablet;

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Le titre
            Text(
              "Click and Collect",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Theme.of(context).colorScheme.secondary
              ),
            ),
            Container(
              height: 1,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 20,),

            for (final category in products.keys) ...{
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
              for (final product in products[category]!) ...{
                if (isBig)
                  _buildBigProductLine(product)
                else 
                  _buildSmallProductLine(product),

                const SizedBox(height: 5,),
              }
            }
              
          ],
        );
      }
    );
  }

  Widget _buildBigProductLine(CCProduct product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Le nom du produit
        SizedBox(
          width: 300,
          child: _buildProductName(product)
        ),

        // La check box pour l'épuisement
        SizedBox(
          width: 200,
          child: _buildProductOutOfStock(product)
        ),

        SizedBox(
          width: 60,
          child: _buildProductPrice(product)
        )
      ],
    );
  }

  Widget _buildSmallProductLine(CCProduct product) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildProductName(product),

        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProductOutOfStock(product, showText: true),
              _buildProductPrice(product)
            ],
          ),
        )
      ],
    );
  }

  Widget _buildProductName(CCProduct product) {
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
              product.quantity.toString(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(width: 4,),

        Text(product.product.name, style: Theme.of(context).textTheme.titleMedium,),
      ],
    );
  }

  Widget _buildProductOutOfStock(CCProduct product, { bool showText = false }) {
    return ClCheckBox(
      value: _outOfStockProducts.contains(product.product.id), 
      text: showText ? "Produit épuisé ?" : "",
      onChanged: (value) {
        if ((value ?? false) && product.product.id != null) {
          setState(() {
            _outOfStockProducts.add(product.product.id!);
          });
        }
        else if (product.product.id != null) {
          setState(() {
            _outOfStockProducts.remove(product.product.id);
          });
        }
      }, 
    );
  }

  Widget _buildProductPrice(CCProduct product) {
    return Text("${(product.product.price ?? 0).toStringAsFixed(2)}€", style: Theme.of(context).textTheme.titleMedium,);
  }

  Map<String, List<CCProduct>> _sortProducts() {
    final Map<String, List<CCProduct>> sorted = {};

    for (final product in widget.command.products) {
      if (sorted.containsKey(product.product.categories.first)) {
        sorted[product.product.categories.first]!.add(product);
      }
      else {
        sorted[product.product.categories.first] = [
          product
        ];
      }

    }
    
    return sorted;
  }
}