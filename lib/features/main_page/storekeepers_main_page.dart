import 'package:chemin_du_local/core/helpers/app_manager.dart';
import 'package:chemin_du_local/features/commands/storekeeper_commands/storekeeper_commands_page.dart';
import 'package:chemin_du_local/features/main_page/main_page.dart';
import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/products_main_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/services.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_page/services_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_home/storekeeper_home_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/storekeeper_page.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_settings/storekeeper_settings_page.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
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
    final bool shouldShowCommands = Services.hasClickAndCollect(widget.storekeeper.commerce?.services ?? []) || Services.hasPaniers(widget.storekeeper.commerce?.services ?? []);

    final int commandsOffset = shouldShowCommands ? 1 : 0;

    // The menu items
    List<PageItem> pageItems = [
      // Stores
      const PageItem(
        index: 0, 
        title: "Ma Page",
        appBarTitle: "Ma Page",
        icon: CLIcons.maPage,
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
        icon: CLIcons.mesProduits
      ),

      // Click and collect if need
      if (shouldShowCommands) 
        const PageItem(
          index: 3, 
          title: "Mes commandes", 
          appBarTitle: "Mes commandes",
          icon: CLIcons.clickAndCollect,
        ),

      // Basket
      PageItem(
        index: 3 + commandsOffset,
        title: "Mes Servives",
        appBarTitle: "Mes Services",
        icon: CLIcons.mesServices
      ),

      // Account
      PageItem(
        index: 4 + commandsOffset,
        title: "Paramètres",
        appBarTitle: "Paramètres",
        icon: CLIcons.parametres 
      )
    ];

    // The pages
    final List<Widget> pages = [
      StoreKeeperPage(
        canEdit: true,
        onShowProducts: () => _mainPageKey.currentState!.selectedPage(pageItems[2]),
        onShowDrawer: () => _mainPageKey.currentState!.showDrawer(),
      ),
      StoreKeeperHomePage(
        onPageChanged: (index) => _mainPageKey.currentState!.selectedPage(pageItems[index]),
        onShowDrawer: () => _mainPageKey.currentState!.showDrawer(),
        commerceID: widget.storekeeper.commerce?.id ?? "",
        servicesOffset: commandsOffset,
        services: widget.storekeeper.commerce?.services ?? [],
      ),
      ClipRect(
        child: Navigator(
          key: AppManager.instance.productsPageKey,
          onGenerateRoute: (route) => MaterialPageRoute<void>(
            settings: route,
            builder: (context) => ProductsMainPage(
              isStorekeeper: true,
              onShowDrawer: () => _mainPageKey.currentState!.showDrawer(),
            )
          ),
        )
      ),
      if (shouldShowCommands) 
         ClipRect(
          child: Navigator(
            key: AppManager.instance.clickAndCollectPageKey,
            onGenerateRoute: (route) => MaterialPageRoute<void>(
              settings: route,
              builder: (context) => StoreKeeperCommandsPage(
                onShowDrawer: () => _mainPageKey.currentState!.showDrawer(),
              )
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
              onShowDrawer: () => _mainPageKey.currentState!.showDrawer(),
            )
          ),
        )
      ),
      StoreKeeperSettingsPage(
        onShowDrawer: () => _mainPageKey.currentState!.showDrawer(),
      )
    ];

    return MainPage(
      key: _mainPageKey,
      pageItems: pageItems, 
      pages: pages
    );
  }
}