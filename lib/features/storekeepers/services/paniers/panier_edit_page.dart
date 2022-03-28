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
    required this.panierID
  }) : super(key: key);

  final String? panierID;

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
      document: gql(widget.panierID == null ? mutCreatePanier : ""),
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
    
        return const Text("Edition");
        
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