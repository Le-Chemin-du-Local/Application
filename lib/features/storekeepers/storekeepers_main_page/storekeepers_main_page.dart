import 'package:chemin_du_local/features/main_page/main_page.dart';
import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_home/storekeeper_home_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/storekeeper_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_products/storekeeper_products_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_settings/storekeeper_settings_page.dart';
import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:flutter/material.dart';

class StoreKeepersMainPage extends StatefulWidget {
  const StoreKeepersMainPage({Key? key}) : super(key: key);

  @override
  State<StoreKeepersMainPage> createState() => _StoreKeepersMainPageState();
}

class _StoreKeepersMainPageState extends State<StoreKeepersMainPage> {
  final GlobalKey<MainPageState> _mainPageKey = GlobalKey<MainPageState>();

  @override
  Widget build(BuildContext context) {
    // The menu items
    const List<PageItem> pageItems = [
      // Stores
      PageItem(
        index: 0, 
        title: "Ma Page",
        appBarTitle: "Ma Page",
        icon: CLIcons.mapage,
      ),

      // Home page
      PageItem(
        index: 1, 
        title: "Accueil",
        appBarTitle: "Bienvenue",
        icon: CLIcons.accueil
      ),

      // Fidelity
      PageItem(
        index: 2,
        title: "Mes Produits",
        appBarTitle: "Mes Produtis",
        icon: CLIcons.mesproduits
      ),

      // Basket
      PageItem(
        index: 3,
        title: "Mes Servives",
        appBarTitle: "Mes Services",
        icon: CLIcons.messervices
      ),

      // Account
      PageItem(
        index: 4,
        title: "Paramètres",
        appBarTitle: "Paramètres",
        icon: CLIcons.parametres 
      )
    ];

    // The pages
    final List<Widget> pages = [
      const StoreKeeperPage(),
      StoreKeeperHomePage(
        onPageChanged: (index) => _mainPageKey.currentState!.selectedPage(pageItems[index]),
      ),
      const StoreKeeperProductsPage(),
      const ServicesPage(),
      const StoreKeeperSettingsPage()
    ];

    return MainPage(
      key: _mainPageKey,
      pageItems: pageItems, 
      pages: pages
    );
  }
}