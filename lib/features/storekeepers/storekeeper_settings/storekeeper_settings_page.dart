import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:flutter/material.dart';

class StoreKeeperSettingsPage extends StatelessWidget {
  const StoreKeeperSettingsPage({
    Key? key,
    required this.onShowDrawer,
  }) : super(key: key);

  final Function() onShowDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: false,
        onShowDrawer: onShowDrawer,
        title: const Text("Bienvenue, Victor 👋"),
      ),
      body: const Center(child: Text("Hello StoreKeeper Settings Page")),
    );
  }
}