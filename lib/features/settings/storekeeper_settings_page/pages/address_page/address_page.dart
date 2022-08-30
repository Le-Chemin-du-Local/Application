import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/place/models/address/address.dart';
import 'package:chemin_du_local/features/place/place_service.dart';
import 'package:chemin_du_local/features/place/widgets/address_controller.dart';
import 'package:chemin_du_local/features/place/widgets/address_form.dart';
import 'package:chemin_du_local/features/storekeepers/storekeepers_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:latlng/latlng.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddressController? _addressController;

  String _errorMessage = "";

  QueryOptions _addressOptions() {
    return QueryOptions<dynamic>(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(r'''
      query GetCommerceAddress {
        commerce {
          id
          name
          address {
            number
            route
            optionalRoute
            postalCode
            city
          }
        }
      }
      ''')
    );
  }

  MutationOptions _addressMutationOptions() {
    return MutationOptions(
      document: gql(mutUpdateStorekeerCommerce),
      onCompleted: (dynamic data) {
        if (data != null) Navigator.of(context).pop();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: const Text("Modifier l'adresse"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.instance.horizontalPadding
          ),
          child: Query<dynamic>(
            options: _addressOptions(),
            builder: (result, {fetchMore, refetch}) {
              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
      
              if (result.hasException) {
                return const Align(
                  alignment: Alignment.topCenter,
                  child: ClStatusMessage(
                    message: "Impossible de charger l'adresse du commerce.",
                  ),
                );
              }
                      
              final Commerce commerce = Commerce.fromJson(result.data!["commerce"] as Map<String, dynamic>);

              if (_addressController == null) {
                _addressController = AddressController();
                _addressController!.address = commerce.address ?? const Address();
              }
      
              return Mutation(
                options: _addressMutationOptions(),
                builder: (runMutation, mutationResult) {
                  if (mutationResult?.isLoading ?? false) {
                    return const Center(child: CircularProgressIndicator(),);
                  }

                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Le message d'erreur si jamais il y en a un
                        if ((mutationResult?.hasException ?? false) || _errorMessage.isNotEmpty) ...{
                          ClStatusMessage(
                            message: _errorMessage.isEmpty ? "Erreur lors de la mise à jour de l'adresse" : _errorMessage,
                          ),
                          const SizedBox(height: 16,),
                        },

                        // Le formulaire d'adresse
                        AddressForm(addressController: _addressController!),
                        const SizedBox(height: 12,),

                        // Le bouton de sauvegarde
                        ElevatedButton(
                          onPressed: () => _onSave(runMutation, commerceID: commerce.id!),
                          child: const Text("Sauvegarder cette adresse"),
                        ),
                        const SizedBox(height: 12,)
                      ],
                    ),
                  );
                }
              );
            },
          ),
        ),
      ),
     );
  }

  Future _onSave(RunMutation? runMutation, {
    required String commerceID,
  }) async {
    if (!_formKey.currentState!.validate()) return;

    LatLng? commerceLatLgn = await PlaceAPIProvider.instance.latLgnForAddress(_addressController!.address.detailled);

    if (commerceLatLgn == null) {
      setState(() {
        _errorMessage = "Nous n'arrivons pas à récupérer les coordonnées du commerce. Verifiez l'adresse.";
      });
    }

    if (runMutation != null) {
      runMutation(<String, dynamic>{
        "id": commerceID,
        "changes": <String, dynamic>{
          "address": _addressController!.address.toJson(),
          "latitude": commerceLatLgn!.latitude,
          "longitude": commerceLatLgn.longitude,
        }
      });
    }
  }
}