import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/main_page/page_item.dart';
import 'package:chemin_du_local/core/main_page/widgets/menu_drawer.dart';
import 'package:chemin_du_local/features/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';

const Map<PagesId, PageItem> pagesItem = {
    PagesId.dashboard: PageItem(id: PagesId.dashboard, title: "Accueil", appBarTitle: "Bienvenue Guillaume", icon: Icons.home),
    PagesId.products: PageItem(id: PagesId.products, title: "Mes Produits", appBarTitle: "Mes Produits", icon: Icons.shopping_basket),
};

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PagesId _currentPageId = PagesId.dashboard;

  @override
  Widget build(BuildContext context) {
    final Map<PagesId, Widget> pages = {
      PagesId.dashboard: DashboardPage(
        onPageChanged: (page) {
          setState(() {
            _currentPageId = page;
          });
        }
      ),
      PagesId.products: const Center(child: Text("Hello page 2")),
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        bool useBigLayout = constraints.maxWidth >= ScreenHelper.breakpointPC;

        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (useBigLayout)
              MenuDrawer(
                onSelectedPage: (pageId) {
                  setState(() {
                    _currentPageId = pageId;
                  });
                }, 
                shouldPop: false, 
                currentPageId: _currentPageId
              ),
            Expanded(
              child: Scaffold(
                appBar: AppBar(title: Text(pagesItem[_currentPageId]?.appBarTitle ?? ""),),
                drawer: useBigLayout ? null : MenuDrawer(
                  onSelectedPage: (pageId) {
                    setState(() {
                      _currentPageId = pageId;
                    });
                  },
                  shouldPop: true,
                  currentPageId: _currentPageId,
                ),
                body: pages[_currentPageId],
              ),
            ),
          ],
        );
      }
    );
  }
}