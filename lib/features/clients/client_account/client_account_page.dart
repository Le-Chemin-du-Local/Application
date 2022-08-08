import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/authentication/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientAccountPage extends ConsumerWidget {
  const ClientAccountPage({
    Key? key,
    required this.onShowDrawer,
  }) : super(key: key);

  final Function() onShowDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isLooged = ref.watch(appUserControllerProvider).token != null;

    if (!isLooged) {
      return LoginPage(
        onShowDrawer: onShowDrawer,
      );
    }

    return const Scaffold(
      body: Center(child: Text("Hello Account")),
    );
  }
}