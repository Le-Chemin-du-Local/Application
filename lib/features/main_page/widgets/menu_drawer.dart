import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/features/main_page/widgets/menu_drawer_item.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key, 
    required this.onSelectedPage, 
    required this.shouldPop,
    required this.currentPageIndex, 
    required this.pageItems,
    this.isMinimified = false
  }) : super(key: key);

  final Function(PageItem) onSelectedPage;
  final bool shouldPop;
  final int currentPageIndex;

  final List<PageItem> pageItems;

  final bool isMinimified;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color:  Theme.of(context).colorScheme.surface,
          border: Border(
            right: BorderSide(
              color: Theme.of(context).colorScheme.outline
            ),
            top: BorderSide(
              color: Theme.of(context).colorScheme.outline
            ),
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.outline
            )
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The logo
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 64,
              child: Center(
                child: Image.asset(
                  isMinimified ? "assets/images/logo_mini.png" : "assets/images/logo.png",
                ),
              ),
            ),
            const SizedBox(height: 32,),

            // The special button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: ElevatedButton.icon(
                onPressed: () => onSelectedPage(pageItems[0]),
                label: Text(pageItems[0].title),
                icon: Icon(pageItems[0].icon),
              ),
            ),
            const SizedBox(height: 32,),

            // The list of pages
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: pageItems.length,
                itemBuilder: (context, index) {
                  // We want to keep the first item which is 
                  // a button
                  if (index == 0) return Container();

                  return InkWell(
                    onTap: () {
                      onSelectedPage(pageItems[index]);
                      if (shouldPop) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: MenuDrawerItem(
                      item: pageItems[index],
                      isActive: index == currentPageIndex,
                      isMinimified: isMinimified, 
                    ),
                  );
                },
              ),
            ),
            // TODO: do
            // BuDrawerProfileInfo(
            //   isMinimified: isMinimified,
            // )
          ],
        ),
      ),
    );
  }
}