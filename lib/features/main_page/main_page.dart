import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/features/main_page/widgets/menu_drawer.dart';
import 'package:chemin_du_local/theme/cl_theme.dart';
import 'package:flutter/material.dart';

import 'package:chemin_du_local/features/main_page/widgets/bottom_app_bar.dart' as custom;

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
    required this.pageItems,
    required this.pages
  }) : assert(pageItems.length == pages.length, "you don't have the same pageItems number than the pages number"), super(key: key);

  final List<PageItem> pageItems;
  final List<Widget> pages;

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 1;

  bool _isMenuBarMinimified = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // TODO: do
        // show confirmation
        // return (await AppManager.instance.showCloseAppConfirmation(context)) ?? false;
        return true;
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool useBigLayout = constraints.maxWidth >= ScreenHelper.breakpointPC;

          return Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (useBigLayout) 
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: _isMenuBarMinimified ? 68 : 312,
                        child: MenuDrawer(
                          pageItems: widget.pageItems,
                          currentPageIndex: _currentIndex,
                          onSelectedPage: selectedPage,
                          shouldPop: false,
                          isMinimified: _isMenuBarMinimified,
                        ),
                      ),
              
                    Expanded(
                      child: Scaffold(
                        appBar:AppBar(
                          title: Text(widget.pageItems[_currentIndex].title),
                          leading: !useBigLayout ? null : IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              setState(() {
                                _isMenuBarMinimified = !_isMenuBarMinimified;
                              });
                            },
                          ),
                        ),
                        body: Theme(
                          data: Theme.of(context).copyWith(
                            appBarTheme: ClTheme.themeSecondAppBar(context)
                          ),
                          child: widget.pages[_currentIndex]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (!useBigLayout)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: custom.BottomAppBar(
                      currentPageIndex: _currentIndex,
                      onSelectedPage: selectedPage,
                      pageItems: widget.pageItems,
                    ),
                  ),
                )
            ],
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
}