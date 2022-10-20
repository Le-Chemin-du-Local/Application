import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/storekeepers_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BankDetailsPage extends StatefulWidget {
  const BankDetailsPage({Key? key}) : super(key: key);

  @override
  State<BankDetailsPage> createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _ibanOwnerTextController = TextEditingController();
  final TextEditingController _ibanTextController = TextEditingController();
  final TextEditingController _bicTextController = TextEditingController();

  QueryOptions _bankDetailsOptions() {
    return QueryOptions(
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      document: gql(r'''
        query GetCommerceAddress {
          commerce {
            id
            name
            iban
            ibanOwner
            bic
          }
        }
      ''')
    );
  }

  MutationOptions _bankDetailsMutationOptions() {
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
      resizeToAvoidBottomInset: false,
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: const Text("Mes informations bancaire"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenHelper.instance.horizontalPadding,
        ),
        child: Query<dynamic>(
          options: _bankDetailsOptions(),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }

            if (result.hasException) {
              return const Align(
                alignment: Alignment.topCenter,
                child: ClStatusMessage(
                  message: "Impossible de charger les informations bancaire.",
                ),
              );
            }

            final Commerce commerce = Commerce.fromJson(result.data!["commerce"] as Map<String, dynamic>);

            // On doit intialiser les valeurs si besoin
            if (_ibanOwnerTextController.text.isEmpty) _ibanOwnerTextController.text = commerce.ibanOwner ?? "";
            if (_ibanTextController.text.isEmpty) _ibanTextController.text = commerce.iban ?? "";
            if (_bicTextController.text.isEmpty) _bicTextController.text = commerce.bic ?? "";

            return Mutation(
              options: _bankDetailsMutationOptions(),
              builder: (runMutation, mutationResult) {
                if (mutationResult?.isLoading ?? false) {
                  return const Center(child: CircularProgressIndicator(),);
                }

                return Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Le formulaire
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // Le titulaire du compte
                              ClTextInput(
                                controller: _ibanOwnerTextController,
                                labelText: "Prénom/Nom du titulaire du compte",
                                hintText: "Owen Plouzeneck",
                                validator: (value) {
                                  if (value.isEmpty) return "Vous devez rentrer un titulaire";
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12,),

                              // L'IBAN
                              ClTextInput(
                                controller: _ibanTextController,
                                labelText: "IBAN",
                                hintText: "FRXXXXXXXXXXXXXXXXXXXXXXXXX",
                                validator: (value) {
                                  if (value.isEmpty) return "Vous devez rentrer un IBAN";
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12,),

                              // Le BIC
                              ClTextInput(
                                controller: _bicTextController,
                                labelText: "BIC",
                                hintText: "Par exemple : SHINXXXX",
                                validator: (value) {
                                  if (value.isEmpty) return "Vous devez rentrer un BIC";
                                  return null;
                                },
                              ),
                              const SizedBox(height: 12,),
                            ],
                          ),
                        ),
                      ),

                      // Le texte d'avertissement
                      const Text("Vos données bancaires ne seront jamais partagées, excepté avec notre prestataire de paiement pour les prélèvements, ou dans le cas où nous serions légalement tenus de le faire (autorités fiscales par exemple)."),
                      const SizedBox(height: 12,),

                      // Le bouton de validation
                      ElevatedButton(
                        onPressed: () => _onSave(runMutation, commerceID: commerce.id!),
                        child: const Text("Terminer"),

                      ),
                      const SizedBox(height: 12,),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future _onSave(RunMutation? runMutation, {
    required String commerceID,
  }) async {
    if (!_formKey.currentState!.validate()) return;

    if (runMutation != null) {
      runMutation(<String, dynamic>{
        "id": commerceID,
        "changes": <String, dynamic> {
          "ibanOwner": _ibanOwnerTextController.text,
          "iban": _ibanTextController.text,
          "bic": _bicTextController.text
        }
      });
    }
  }
}