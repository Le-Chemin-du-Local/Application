import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/main_page/page_item.dart';
import 'package:chemin_du_local/core/main_page/widgets/bottom_app_bar.dart' as custom;
import 'package:chemin_du_local/core/main_page/widgets/menu_drawer.dart';
import 'package:chemin_du_local/features/dashboard/dashboard_page.dart';
import 'package:chemin_du_local/features/products/products_controller.dart';
import 'package:chemin_du_local/features/products/products_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const Map<PagesId, PageItem> pagesItem = {
    PagesId.dashboard: PageItem(id: PagesId.dashboard, title: "Accueil", appBarTitle: "Bienvenue Guillaume", icon: Icons.home),
    PagesId.products: PageItem(id: PagesId.products, title: "Mes Produits", appBarTitle: "Mes Produits", icon: Icons.shopping_basket),
};

class MainPage extends ConsumerStatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  PagesId _currentPageId = PagesId.dashboard;

  @override
  void initState() {
    super.initState();

    ref.read(productsControllerProvider.notifier).loadData();
  }

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
      PagesId.products: const ProductsMainPage()
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        bool useBigLayout = constraints.maxWidth >= ScreenHelper.breakpointPC;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Row(
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
                    child: Navigator(
                      onGenerateRoute: (route) => MaterialPageRoute<dynamic>(
                        settings: route,
                        builder: (context) => Scaffold(
                          appBar: AppBar(title: Text(pagesItem[_currentPageId]?.appBarTitle ?? ""),),
                          body: pages[_currentPageId],
                        )
                      ),
                    ),
                    // child: Scaffold(
                    //   appBar: AppBar(title: Text(pagesItem[_currentPageId]?.appBarTitle ?? ""),),
                    //   // drawer: useBigLayout ? null : MenuDrawer(
                    //   //   onSelectedPage: (pageId) {
                    //   //     setState(() {
                    //   //       _currentPageId = pageId;
                    //   //     });
                    //   //   },
                    //   //   shouldPop: true,
                    //   //   currentPageId: _currentPageId,
                    //   // ),
                    //   body: pages[_currentPageId],
                    // ),
                  ),
                ],
              ),
            ),
            if (!useBigLayout)
              Container(
                height: 64,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: const Border(
                    top: BorderSide(
                      color: Color(0xffd9d9d9),
                      width: 0.5
                    )
                  )
                ),
                child: custom.BottomAppBar(
                  currentPageId: _currentPageId,
                  onSelectedPage: (page) {
                    setState(() {
                      _currentPageId = page;
                    });
                  },
                ),
              )
          ],
        );
      }
    );
  }
}