import 'package:flutter/material.dart';

class AppManager {
  AppManager._();

  static final AppManager instance = AppManager._();

  final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

  // CLIENTS KEYS
  final GlobalKey<NavigatorState> homePageKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> commercesListPageKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> basketPageKey = GlobalKey<NavigatorState>();

  // STOREKEEPERS KEYS
  final GlobalKey<NavigatorState> productsPageKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> clickAndCollectPageKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> serviesPageKey = GlobalKey<NavigatorState>();

  // BASKET
  int basketPageIndex = 0;

  Future<bool?> showCloseAppConfirmation(BuildContext context) async {
    if (homePageKey.currentState?.canPop() ?? false) {
      commercesListPageKey.currentState!.pop();
      return false;
    }

    if (commercesListPageKey.currentState?.canPop() ?? false) {
      commercesListPageKey.currentState!.pop();
      return false;
    }

    if ((basketPageKey.currentState?.canPop() ?? false) ||
        (basketPageKey.currentState != null && basketPageIndex >= 1)) {
      basketPageKey.currentState!.maybePop();
      return false;
    }

    if (productsPageKey.currentState?.canPop() ?? false) {
      productsPageKey.currentState!.pop();
      return false;
    }

    if (clickAndCollectPageKey.currentState?.canPop() ?? false) {
      clickAndCollectPageKey.currentState!.pop();
      return false;
    }

    if (serviesPageKey.currentState?.canPop() ?? false) {
      serviesPageKey.currentState!.pop();
      return false;
    }

    if (appNavigatorKey.currentState?.canPop() ?? false) {
      appNavigatorKey.currentState!.pop();
      return false;
    }

    // Dabs le dernier cas, on afficge la confirmation
    return await showDialog<bool?>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text("Etes vous sur de vouloir quitter l'application ?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Oui'),
          ),
        ],
      ),
    );
  }
}