import 'package:chemin_du_local/core/helpers/screen_helper.dart';
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
      appBar: AppBar(
        leading: ScreenHelper.instance.isMobile ? null : Padding(
          padding: EdgeInsets.only(
            left: ScreenHelper.instance.horizontalPadding,
          ),
          child: IconButton(
            onPressed: () {
              onShowDrawer();
            },
            icon: const Icon(Icons.menu)
          ),
        ),
        leadingWidth: 32 + ScreenHelper.instance.horizontalPadding,
        title: const Text("Mon compte fidélité"),
      ),
      body: const Center(child: Text("Hello Fidelity page"),),
    );
  }
}