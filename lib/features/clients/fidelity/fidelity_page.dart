import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:flutter/material.dart';

class FidelityPage extends StatelessWidget {
  const FidelityPage({
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
        title: const Text("Mon compte fidélité"),
      ),
      body: const Center(child: Text("Hello Fidelity page"),),
    );
  }
}