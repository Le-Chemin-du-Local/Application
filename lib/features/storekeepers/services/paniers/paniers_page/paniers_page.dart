import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/models/panier/panier.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier_edit_page/panier_edit_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_graphql.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_page/widgets/panier_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_page/widgets/panier_type_dialog.dart';
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
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: const Text("Paniers")
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAddNewPanier(context),
        child: const Icon(Icons.add),
      )
    );
  }

  Widget _buildGrid(BuildContext context, String type) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Le titre
        if (type == PanierType.temporary) 
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
            child: Text("En cours flash", style: Theme.of(context).textTheme.titleMedium,),
          ),
        if (type == PanierType.permanent) 
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
            child: Text("En cours permanent", style: Theme.of(context).textTheme.titleMedium,),
          ),
        const SizedBox(height: 12,),

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
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
                child: const ClStatusMessage(
                  message: "Nous ne parvenons pas à charger les paniers...",
                ),
              );
            }

            final List mapPaniers = result.data!["commerce"]["paniers"]["edges"] as List;
            final List<Panier> paniers = [];

            for (final mapPanier in mapPaniers) {
              paniers.add(Panier.fromJson(mapPanier["node"] as Map<String, dynamic>));
            }

            if (paniers.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
                child: const ClStatusMessage(
                  type: ClStatusMessageType.info,
                  message: "Aucun panier n'a été créé pour le moment. Pour en rajouter un, utiliser le \"+\" en bas à droite.",
                ),
              );
            }

            return ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 266),
              child: ListView(
                controller: ScrollController(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: ScreenHelper.instance.horizontalPadding,),
                  for (final panier in paniers) 
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 524),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: PanierCard(
                          panier: panier, 
                          onOpen: () {},
                          onView: () => _onViewPanier(context, panier),
                        ),
                      ),
                    ),
                ]
              ),
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

  Future _onViewPanier(BuildContext context, Panier panier) async {
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