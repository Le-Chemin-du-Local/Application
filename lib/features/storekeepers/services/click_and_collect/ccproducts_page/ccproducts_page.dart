import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/services_products_picker.dart';
import 'package:flutter/material.dart';

class CCProductsPage extends StatefulWidget {
  const CCProductsPage({Key? key}) : super(key: key);

  @override
  State<CCProductsPage> createState() => _CCProductsPageState();
}

class _CCProductsPageState extends State<CCProductsPage> {
  final List<String> _productsIDs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gérer mes produits click and collect"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ScreenHelper.horizontalPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Chackbox
            ClCheckBox(
              text: "Ajouter tous les produits au click and collect",
              value: false,
              onChanged: (value) {},
            ),

            // List des produits
            Expanded(
              child: SingleChildScrollView(
                child: ServicesProductsPicker(
                  initialProductsIDs: _productsIDs,
                  onProductTapped: (productID) {
                    setState(() {
                      if (_productsIDs.contains(productID)) {
                        _productsIDs.remove(productID);
                      } 
                      else {
                        _productsIDs.add(productID);
                      }
                    });
                  }),
              ),
            )
          ],
        ),
      ),
    );
  }
}