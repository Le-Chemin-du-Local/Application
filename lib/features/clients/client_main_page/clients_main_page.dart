import 'package:chemin_du_local/features/clients/client_account/client_account_page.dart';
import 'package:chemin_du_local/features/clients/client_basket/client_basket_page.dart';
import 'package:chemin_du_local/features/clients/client_home/client_home_page.dart';
import 'package:chemin_du_local/features/clients/fidelity/fidelity_page.dart';
import 'package:chemin_du_local/features/commerces/commerces_page.dart';
import 'package:chemin_du_local/features/main_page/main_page.dart';
import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:flutter/material.dart';

class ClientsMainPage extends StatelessWidget {
  const ClientsMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The pages
    final List<Widget> pages = [
      const CommercesPage(),
      const ClientHomePage(),
      const FidelityPage(),
      const ClientBasketPage(),
      const ClientAccountPage()
    ];

    // The menu items
    const List<PageItem> pageItems = [
      // Stores
      PageItem(
        index: 0, 
        title: "Les commerces",
        appBarTitle: "Les commerces",
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
        title: "Fidélité",
        appBarTitle: "Votre fidélité",
        icon: Icons.storage
      ),

      // Basket
      PageItem(
        index: 3,
        title: "Paniers",
        appBarTitle: "Votre paniers",
        icon: CLIcons.clickandcollect
      ),

      // Account
      PageItem(
        index: 4,
        title: "Mon compte",
        appBarTitle: "Mon Compte",
        icon: Icons.account_circle 
      )
    ];

    return MainPage(
      pageItems: pageItems, 
      pages: pages
    );
  }
}