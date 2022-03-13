import 'package:flutter/material.dart';

class AppManager {
  AppManager._();

  static final AppManager instance = AppManager._();

  final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

  // STOREKEEPERS KEYS
  final GlobalKey<NavigatorState> productsPageKey = GlobalKey<NavigatorState>();
}