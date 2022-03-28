import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier_edit_page.dart';
import 'package:flutter/material.dart';

class PaniersPage extends StatelessWidget {
  const PaniersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paniers")),
      body: const Text("Hello Paniers"),
      floatingActionButton: ClFloatingButton(
        icon: Icons.add,
        onPressed: () => _onAddNewPanier(context),
      )
    );
  }

  Future _onAddNewPanier(BuildContext context) async {
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => const PanierEditPage(panierID: null)
      )
    );
  }
}