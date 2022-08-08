import 'package:chemin_du_local/core/helpers/app_manager.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_page.dart';
import 'package:chemin_du_local/features/clients/client_account/client_account_page.dart';
import 'package:chemin_du_local/features/clients/client_home/client_home_page.dart';
import 'package:chemin_du_local/features/clients/fidelity/fidelity_page.dart';
import 'package:chemin_du_local/features/commerces/commerces_list_page.dart/commerces_list_page.dart';
import 'package:chemin_du_local/features/main_page/main_page.dart';
import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:flutter/material.dart';

class ClientsMainPage extends StatefulWidget {
  const ClientsMainPage({
    Key? key,
    this.returnToBasketPayment = false,
  }) : super(key: key);

  final bool returnToBasketPayment;

  @override
  State<ClientsMainPage> createState() => _ClientsMainPageState();
}

class _ClientsMainPageState extends State<ClientsMainPage> {
  final GlobalKey<MainPageState> _mainPageKey = GlobalKey<MainPageState>();

  @override
  Widget build(BuildContext context) {
    // The pages
    final List<Widget> pages = [
      ClipRect(
        child: Navigator(
          key: AppManager.instance.commercesListPageKey,
          onGenerateRoute: (route) => MaterialPageRoute<void>(
            settings: route,
            builder: (context) => const CommercesListPage()
          ),
        )
      ),
      ClipRect(
        child: Navigator(
          key: AppManager.instance.homePageKey,
          onGenerateRoute: (route) => MaterialPageRoute<void>(
            settings: route,
            builder: (context) => ClientHomePage(
              onShowDrawer: () => _mainPageKey.currentState!.showDrawer(),
            )
          ),
        )
      ),
      FidelityPage(
        onShowDrawer: () => _mainPageKey.currentState!.showDrawer()
      ),
      ClipRect(
        child: Navigator(
          key: AppManager.instance.basketPageKey,
          onGenerateRoute: (route) => MaterialPageRoute<void>(
            settings: route,
            builder: (context) => BasketPage(
              onShowDrawer: () => _mainPageKey.currentState!.showDrawer(),
            )
          ),
        )
      ),
      ClientAccountPage(
        onShowDrawer: () => _mainPageKey.currentState!.showDrawer(),
      )
    ];

    // The menu items
    const List<PageItem> pageItems = [
      // Stores
      PageItem(
        index: 0, 
        title: "Les commerces",
        appBarTitle: "Les commerces",
        icon: CLIcons.rechercheCommerces,
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
        title: "Fidélité",
        appBarTitle: "Votre fidélité",
        icon: CLIcons.coin
      ),

      // Basket
      PageItem(
        index: 3,
        title: "Paniers",
        appBarTitle: "Votre paniers",
        icon: CLIcons.clickAndCollect,
        isBasket: true
      ),

      // Account
      PageItem(
        index: 4,
        title: "Mon compte",
        appBarTitle: "Mon Compte",
        icon: CLIcons.hermine
      )
    ];

    return MainPage(
      key: _mainPageKey,
      pageItems: pageItems, 
      pages: pages,
      overrideStartIndex: widget.returnToBasketPayment ? 3 : 1,
    );
  }
}