import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier_edit_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/widgets/panier_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/widgets/panier_type_dialog.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PaniersPage extends StatefulWidget {
  const PaniersPage({Key? key}) : super(key: key);

  @override
  State<PaniersPage> createState() => _PaniersPageState();
}

class _PaniersPageState extends State<PaniersPage> {
  bool _shouldRefetch1 = false;
  bool _shouldRefetch2 = false;

  QueryOptions _paniersQueryOptions(String type) {
    return QueryOptions<dynamic>(
      document: gql(qPaniers),
      variables: <String, dynamic>{
        "type": type
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paniers")),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: ScreenHelper.horizontalPadding,
          right: ScreenHelper.horizontalPadding
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildGrid(context, PanierType.temporary),
              const SizedBox(height: 12,),
              _buildGrid(context, PanierType.permanent),
            ],
          ),
        ),
      ),
      floatingActionButton: ClFloatingButton(
        icon: Icons.add,
        onPressed: () => _onAddNewPanier(context),
      )
    );
  }

  Widget _buildGrid(BuildContext context, String type) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Le titre
        if (type == PanierType.permanent) 
          Text("Paniers en cours permanent", style: Theme.of(context).textTheme.headline2,),
        if (type == PanierType.temporary) 
          Text("Paniers en cours temporaire", style: Theme.of(context).textTheme.headline2,),

        // Les paniers
        Query<dynamic>(
          options: _paniersQueryOptions(type),
          builder: (result, {fetchMore, refetch}) {
            if (_shouldRefetch1) {
              if (refetch != null) refetch();
              _shouldRefetch1 = false;
            }
            else if (_shouldRefetch2) {
              if (refetch != null) refetch();
              _shouldRefetch2 = false;
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }

            if (result.hasException) {
              return const ClStatusMessage(
                message: "Nous ne parvenons pas à charger les paniers...",
              );
            }

            final List mapPaniers = result.data!["commerce"]["paniers"]["edges"] as List;
            final List<Panier> paniers = [];

            for (final mapPanier in mapPaniers) {
              paniers.add(Panier.fromJson(mapPanier["node"] as Map<String, dynamic>));
            }

            if (paniers.isEmpty) {
              return const ClStatusMessage(
                type: ClStatusMessageType.info,
                message: "Aucun panier n'a été créé pour le moment. Pour en rajouter un, utiliser le \"+\" en bas à droite.",
              );
            }

            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                for (final panier in paniers) 
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600, maxHeight: 240),
                    child: PanierCard(
                      panier: panier, 
                      onOpen: () => _onOpenPanier(context, panier)
                                  ),
                  ),
              ]
            );
          },
        ),
      ]
    );
  }

  Future _onAddNewPanier(BuildContext context) async {
    final String? category = await showDialog(
      context: context, 
      builder: (context) => const PanierTypeDialog()
    );
    
    if (category == null) return;

    bool shouldRefetch = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => PanierEditPage(
          panierID: null,
          panierType: category,
        )
      )
    ) ?? false;

    if (shouldRefetch) {
      setState(() {
        _shouldRefetch1 = true;
        _shouldRefetch2 = true;
      });
    }
  }

  Future _onOpenPanier(BuildContext context, Panier panier) async {
    bool shouldRefetch = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => PanierEditPage(panierID: panier.id, panierType: panier.type,)
      )
    ) ?? false;

    if (shouldRefetch) {
      setState(() {
        _shouldRefetch1 = true;
        _shouldRefetch2 = true;
      });
    }
  }
}