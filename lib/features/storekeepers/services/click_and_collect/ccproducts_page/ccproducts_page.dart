import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/click_and_collect_grahpql.dart';
import 'package:chemin_du_local/features/storekeepers/services/widgets/services_products_picker.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CCProductsPage extends StatefulWidget {
  const CCProductsPage({
    Key? key,
    required this.commerceID,
  }) : super(key: key);

  final String commerceID;

  @override
  State<CCProductsPage> createState() => _CCProductsPageState();
}

class _CCProductsPageState extends State<CCProductsPage> {
  final List<String> _productsIDs = [];

  String _statusMessage = "";
  bool _isSuccessful = false;

  bool _hasBeenInitialized = false;

  MutationOptions _updateProductsClickAndCollect() {
    return MutationOptions<dynamic>(
      document: gql(mutUpdateCCProductsAvailability),
      onError: (error) {
        _statusMessage = "Nous n'avons pas pu mettre à jour la liste des produits disponibles en click and collect";
        _isSuccessful = false;
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        _statusMessage = "La liste à bien été mis à jour !";
        _isSuccessful = true;
      }
    );
  }

  QueryOptions _availableProductsForCCQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qProductsAvailableForClickAndCollect),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Mutation<dynamic>(
      options: _updateProductsClickAndCollect(),
      builder: (runMutation, mutationResult) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Gérer mes produits click and collect"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ScreenHelper.horizontalPadding,
            ),
            child: Query<dynamic>(
              options: _availableProductsForCCQueryOptions(),
              builder: (queryResult, {fetchMore, refetch}) {
                if ((mutationResult?.isLoading ?? false) || queryResult.isLoading) {
                  return const Center(child: CircularProgressIndicator(),);  
                }

                final Commerce commerce = Commerce.fromJson(queryResult.data!["commerce"] as Map<String, dynamic>);
                if (!_hasBeenInitialized) {
                  for (final product in commerce.productsAvailableForClickAndCollect) {
                    _productsIDs.add(product.id!);
                  }
                  _hasBeenInitialized = true;
                }
                
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Un message d'info si besoin
                    if (_statusMessage.isNotEmpty) ...{
                      ClStatusMessage(
                        type: _isSuccessful ? ClStatusMessageType.success : ClStatusMessageType.error,
                        message: _statusMessage,
                      ),
                      const SizedBox(height: 12,)
                    },

                    if (queryResult.hasException) ...{
                      const ClStatusMessage(
                        message: "Nous n'arrivons pas à charger les produits...",
                      ),
                      const SizedBox(height: 20,),
                    },

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
                          onProductTapped: (product) {
                            setState(() {
                              if (_productsIDs.contains(product.id)) {
                                _productsIDs.remove(product.id);
                              } 
                              else {
                                _productsIDs.add(product.id!);
                              }
                            });
                          }),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          floatingActionButton: ClFloatingButton(
            icon: Icons.save,
            onPressed: () => _onSave(runMutation),
          ),
        );
      }
    );
  }

  void _onSave(RunMutation? runMutation) {
    if (runMutation != null) {
      runMutation(<String, dynamic>{
        "id": widget.commerceID,
        "productsIDs": _productsIDs
      });
    }
  }
}