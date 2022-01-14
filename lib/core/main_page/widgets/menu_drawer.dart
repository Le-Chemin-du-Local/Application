
import 'package:chemin_du_local/core/main_page/main_page.dart';
import 'package:chemin_du_local/core/main_page/page_item.dart';
import 'package:chemin_du_local/core/main_page/widgets/user_drawer_widget.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    Key? key, 
    required this.onSelectedPage,
    required this.shouldPop,
    required this.currentPageId,
  }) : super(key: key);

  final Function(PagesId) onSelectedPage;
  final bool shouldPop;
  final PagesId currentPageId;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: const Border(
            right: BorderSide(
              color: Color(0xffd9d9d9),
              width: 0.5
            )
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(color: Colors.grey, height: 52,),
            const SizedBox(height: 32,),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  _buildPageItem(context, pagesItem[PagesId.dashboard]!, isActive: currentPageId == PagesId.dashboard),
                  _buildPageItem(context, pagesItem[PagesId.products]!, isActive: currentPageId == PagesId.products),
                ],
              ),
            ),
            const UserDrawerWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildPageItem(BuildContext context, PageItem item, {required bool isActive}) {
    return DefaultTextStyle(
      style: TextStyle(color: isActive ? Theme.of(context).primaryColor : Palette.colorDarkGrey),
      child: InkWell(
         onTap: () {
          onSelectedPage(item.id);
          if (shouldPop) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              left: BorderSide(
                width: 5,
                color: isActive ? Theme.of(context).primaryColor : Colors.transparent
              )
            )
          ),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Icon(item.icon, size: 24, color: isActive ? Theme.of(context).primaryColor : Palette.colorDarkGrey),
              ),
              const SizedBox(width: 16,),
              Expanded(
                flex: 8,
                child: Text(item.title),
              )
            ], 
          ),
        ),
      ),
    );
  }
}