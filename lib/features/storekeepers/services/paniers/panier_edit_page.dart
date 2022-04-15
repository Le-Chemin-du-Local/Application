import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/widgets/panier_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PanierEditPage extends StatefulWidget {
  const PanierEditPage({
    Key? key,
    required this.panierID,
    required this.panierType,
  }) : super(key: key);

  final String? panierID;
  final String panierType;

  @override
  State<PanierEditPage> createState() => _PanierEditPageState();
}

class _PanierEditPageState extends State<PanierEditPage> {
  String _errorMessage = "";

  final GlobalKey<PanierEditFormState> _panierFormState = GlobalKey<PanierEditFormState>();

  QueryOptions _detailledPanierQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qDetailledPanier),
      variables: <String, dynamic>{
        "id": widget.panierID
      }
    );
  }

  MutationOptions _productMutationOption() {
    return MutationOptions<dynamic>(
      document: gql(widget.panierID == null ? mutCreatePanier : mutUpdatePanier),
      onError: (error) {
        _errorMessage = "Nous ne parvenons pas à envoyer le panier...";
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        Navigator.of(context).pop(true);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Mutation<dynamic>(
      options: _productMutationOption(),
      builder: (runMutation, result) {
        if (result?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (widget.panierID == null) {
          return _buildContent(null, runMutation);
        } 
    
        return Query<dynamic>(
          options: _detailledPanierQueryOptions(),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return Scaffold(
                appBar: AppBar(),
                body: const Center(child: CircularProgressIndicator(),),
              );
            }

            if (result.hasException) {
              return Scaffold(
                appBar: AppBar(),
                body: const Align(
                  alignment: Alignment.topCenter,
                  child: ClStatusMessage(
                    message: "Nous ne parvenons pas à charger le panier...",
                  ),
                ),
              );
            }

            final Panier panier = Panier.fromJson(result.data!["panier"] as Map<String, dynamic>);

            return _buildContent(panier, runMutation);
          },
        );
      }, 
    );
  }

  Widget _buildContent(Panier? panier, RunMutation? runMutation) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.panierID != null ? "Modifier le panier" : "Créer un panier"
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_errorMessage.isNotEmpty) ...{
            ClStatusMessage(
              message: _errorMessage,
            ),
            const SizedBox(height: 20,)
          },

          Flexible(
            child: PanierEditForm(
              key: _panierFormState,
              panier: panier, 
              type: widget.panierType,
              runMutation: runMutation,
            )
          ),
        ],
      ),
      floatingActionButton: ClFloatingButton(
        icon: Icons.save,
        onPressed: _onSave,
      ),
    );
  }

  void _onSave() {
    _panierFormState.currentState!.save();
  }
}