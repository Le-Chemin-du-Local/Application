import 'package:chemin_du_local/core/helpers/app_manager.dart';
import 'package:chemin_du_local/features/commands/storekeeper_commands/storekeeper_commands_page.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/main_page/main_page.dart';
import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/products_main_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_home/storekeeper_home_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/storekeeper_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_settings/storekeeper_settings_page.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:flutter/material.dart';

class StoreKeepersMainPage extends StatefulWidget {
  const StoreKeepersMainPage({
    Key? key,
    required this.storekeeper,
  }) : super(key: key);

  final User storekeeper;

  @override
  State<StoreKeepersMainPage> createState() => _StoreKeepersMainPageState();
}

class _StoreKeepersMainPageState extends State<StoreKeepersMainPage> {
  final GlobalKey<MainPageState> _mainPageKey = GlobalKey<MainPageState>();

  @override
  Widget build(BuildContext context) {
    final bool hasClickAndCollect = (widget.storekeeper.commerce?.services ?? []).contains(CommerceServices.clickAndCollect);
    final int clickAndCollectOffset = hasClickAndCollect ? 1 : 0;

    // The menu items
    List<PageItem> pageItems = [
      // Stores
      const PageItem(
        index: 0, 
        title: "Ma Page",
        appBarTitle: "Ma Page",
        icon: CLIcons.mapage,
      ),

      // Home page
      const PageItem(
        index: 1, 
        title: "Accueil",
        appBarTitle: "Bienvenue",
        icon: CLIcons.accueil,
      ),

      // Fidelity
      const PageItem(
        index: 2,
        title: "Mes Produits",
        appBarTitle: "Mes Produtis",
        icon: CLIcons.mesproduits
      ),

      // Click and collect if need
      if (hasClickAndCollect) 
        const PageItem(
          index: 3, 
          title: "Mes commandes", 
          appBarTitle: "Mes commandes",
          icon: CLIcons.clickandcollect,
        ),

      // Basket
      PageItem(
        index: 3 + clickAndCollectOffset,
        title: "Mes Servives",
        appBarTitle: "Mes Services",
        icon: CLIcons.messervices
      ),

      // Account
      PageItem(
        index: 4 + clickAndCollectOffset,
        title: "Paramètres",
        appBarTitle: "Paramètres",
        icon: CLIcons.parametres 
      )
    ];

    // The pages
    final List<Widget> pages = [
      const StoreKeeperPage(canEdit: true),
      StoreKeeperHomePage(
        onPageChanged: (index) => _mainPageKey.currentState!.selectedPage(pageItems[index]),
        commerceID: widget.storekeeper.commerce?.id ?? "",
        servicesOffset: clickAndCollectOffset,
        services: widget.storekeeper.commerce?.services ?? [],
      ),
      ClipRect(
        child: Navigator(
          key: AppManager.instance.productsPageKey,
          onGenerateRoute: (route) => MaterialPageRoute<void>(
            settings: route,
            builder: (context) => const ProductsMainPage()
          ),
        )
      ),
      if (hasClickAndCollect) 
         ClipRect(
          child: Navigator(
            key: AppManager.instance.clickAndCollectPageKey,
            onGenerateRoute: (route) => MaterialPageRoute<void>(
              settings: route,
              builder: (context) => const StoreKeeperCommandsPage()
            ),
          )
        ),
      ClipRect(
        child: Navigator(
          key: AppManager.instance.serviesPageKey,
          onGenerateRoute: (route) => MaterialPageRoute<void>(
            settings: route,
            builder: (context) => ServicesPage(
              onPageChanged: (index) => _mainPageKey.currentState!.selectedPage(pageItems[index]),
            )
          ),
        )
      ),
      const StoreKeeperSettingsPage()
    ];

    return MainPage(
      key: _mainPageKey,
      pageItems: pageItems, 
      pages: pages
    );
  }
}