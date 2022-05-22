import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/services_product_picker_card.dart';
import 'package:flutter/material.dart';

class ServicesProductsPickerRow extends StatefulWidget {
  const ServicesProductsPickerRow({
    Key? key,
    required this.category,
    required this.initialProductsIDs,
    required this.products,
    required this.onProductTapped,
    this.initialQuantities,
    this.onQuantityChanged,
  }) : super(key: key);

  final String category;

  final List<String> initialProductsIDs;
  final Map<String, int>? initialQuantities;
  final List<Product> products;

  final Function(Product) onProductTapped;
  final Function(Product,int)? onQuantityChanged;

  @override
  State<ServicesProductsPickerRow> createState() => _ServicesProductsPickerRowState();
}

class _ServicesProductsPickerRowState extends State<ServicesProductsPickerRow> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The header
        Flexible(
          child: Row(
            children: [
              Text(widget.category),
              const SizedBox(width: 12,),

              IconButton(
                icon: Icon(_isExpanded
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.keyboard_arrow_right_outlined
                ),
                splashRadius: 20,
                onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
                }
              )
            ],
          ),
        ),

        // The products list
        Flexible(
          child: AnimatedCrossFade(
            crossFadeState: _isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 200),
            // width: double.maxFnite,
            firstChild: GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 270,
                mainAxisExtent: 273,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16
              ),
              children: [
                for (final product in widget.products) 
                  InkWell(
                    onTap: () => widget.onProductTapped(product),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: ServicesProductCard(
                        product: product,
                        isSelected: widget.initialProductsIDs.contains(product.id),
                        onQuantityChanged: widget.onQuantityChanged,
                        quantity: widget.initialQuantities?[product.id]
                      ),
                    )
                  )
              ]
            ),
            secondChild: Container(),
          ),
        ),
      ],
    );
  }
}