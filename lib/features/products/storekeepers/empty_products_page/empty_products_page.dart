import 'dart:typed_data';

import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:chemin_du_local/features/products/product_excel_tools.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EmptyProductsPage extends StatefulWidget {
  const EmptyProductsPage({
    Key? key,
    required this.onProductsAdded,
    required this.onAddProduct,
  }) : super(key: key);

  final Function() onProductsAdded;
  final Function() onAddProduct;

  @override
  State<EmptyProductsPage> createState() => _EmptyProductsPageState();
}

class _EmptyProductsPageState extends State<EmptyProductsPage> {
  String _errorMessage = "";

   MutationOptions<dynamic> _createProductMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(mutCreateProducts),
      onError: (error) {
        _errorMessage = "L'Excel est valide, mais les produits n'ont pas pu être importées...";
      },
      onCompleted: (dynamic data) {
        if (data != null) {
          widget.onProductsAdded();
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
        width: double.infinity,
        child: Mutation<dynamic>(
          options: _createProductMutationOptions(),
          builder: (runMutation, mutationResult) {
            if (mutationResult?.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator(),);
            }

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_errorMessage.isNotEmpty) ...{
                    const SizedBox(height: 64,),
                    ClStatusMessage(message: _errorMessage,),
                    const SizedBox(height: 119,),
                  }
                  else 
                    const SizedBox(height: 183,),
                  const Text(
                    "Affichez dès maintenant vos premiers produits sur votre page !",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  const SizedBox(height: 8.0,),
                  
                  Flexible(child: _buildCheckBoxText('Soit un par un avec le bouton "Ajouter mon premier produit"')),
                  Flexible(child: _buildCheckBoxText("Soit tous vos produits d'un seul coup grâce au template Excel")),
                  const SizedBox(height: 16.0,),

                  ElevatedButton(
                    onPressed: widget.onAddProduct,
                    child: const Text("Ajouter mon premier produit"),
                  ),

                  const SizedBox(height: 8.0,),
                  const Text("ou"),
                  const SizedBox(height: 8.0,),

                  OutlinedButton(
                    onPressed: _downloadExcelTemplate,
                    child: const Text("Télécharger le template Excel"),
                  ),
                  const SizedBox(height: 8.0,),

                  OutlinedButton(
                    onPressed: () => _openExcelProducts(runMutation),
                    child: const Text("Importer mon fichier Excel"),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }

  Widget _buildCheckBoxText(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Checkbox(
            value: true,
            onChanged: (value) {},
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 8,),
    
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(text, style: const TextStyle(fontWeight: FontWeight.normal),)
          ),
        )
      ],
    );
  }

  void _downloadExcelTemplate() {

  }

  Future _openExcelProducts(RunMutation? runMutation) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["xlsx"],
      withData: true
    );

    if (result != null) {
      final Uint8List bytes = result.files.first.bytes!;

      try {
        final List<Product> products = ProductExcelTools.instance.readProductsFromExcel(bytes);

        if (runMutation != null) {
          runMutation(<String, dynamic>{
            "input": [
              for (final product in products) 
                <String, dynamic>{
                  "name": product.name,
                  "description": product.description,
                  "price": product.price,
                  "unit": product.unit,
                  "tva": product.tva,
                  "isBreton": product.isBreton,
                  "categories": product.categories,
                }
            ]
          });
        }
      }
      on Error {
        setState(() {
          _errorMessage = "Les produits n'ont pas pu être importés. Vérifiez que tout correspond correctement à la template Excel.";
        });
      }
    }
  }
}