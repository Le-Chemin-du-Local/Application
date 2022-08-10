import 'package:chemin_du_local/core/helpers/app_manager.dart';
import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/features/main_page/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';

import 'package:chemin_du_local/features/main_page/widgets/bottom_app_bar.dart' as custom;

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.pageItems,
    required this.pages,
    this.overrideStartIndex = 1
  }) : assert(pageItems.length == pages.length, "you don't have the same pageItems number than the pages number"), super(key: key);

  final List<PageItem> pageItems;
  final List<Widget> pages;

  final int overrideStartIndex;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _currentIndex = widget.overrideStartIndex;
  }

  @override
  void didUpdateWidget(covariant MainPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    _currentIndex = widget.overrideStartIndex;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // On affiche la confirmation
        return (await AppManager.instance.showCloseAppConfirmation(context)) ?? false;
      },
      child: Builder(
        builder: (context) {
          bool useBigLayout = !ScreenHelper.instance.isMobile;
          // bool useBigLayout = false;

          final List<Color> gradient = [
            Theme.of(context).colorScheme.background,
            Theme.of(context).colorScheme.background,
            Colors.white,
            Colors.white,
          ];
          const double fillPercent = 50; // fills 56.23% for container from bottom
          const double fillStop = (100 - fillPercent) / 100;
          final List<double> stops = [0.0, fillStop, fillStop, 1.0];

          return  Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                stops: stops,
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
              ),
            ),
            child: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                // appBar:AppBar(
                //   title: Text(widget.pageItems[_currentIndex].title),
                // ),
                key: _scaffoldKey,
                body: widget.pages[_currentIndex],
                drawer: useBigLayout 
                  ? MenuDrawer(
                      pageItems: widget.pageItems,
                      currentPageIndex: _currentIndex,
                      onSelectedPage: selectedPage,
                    )
                  : null,
                bottomNavigationBar: useBigLayout ? null : custom.BottomAppBar(
                  currentPageIndex: _currentIndex,
                  onSelectedPage: selectedPage,
                  pageItems: widget.pageItems,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void selectedPage(PageItem pageItem) {
    setState(() {
      _currentIndex = pageItem.index;
    });
  }

  void showDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }
}