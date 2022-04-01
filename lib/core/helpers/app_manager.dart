import 'package:flutter/material.dart';

class AppManager {
  AppManager._();

  static final AppManager instance = AppManager._();

  final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

  // CLIENTS KEYS
  final GlobalKey<NavigatorState> commercesListPageKey = GlobalKey<NavigatorState>();

  // STOREKEEPERS KEYS
  final GlobalKey<NavigatorState> productsPageKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> clickAndCollectPageKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> serviesPageKey = GlobalKey<NavigatorState>();
}