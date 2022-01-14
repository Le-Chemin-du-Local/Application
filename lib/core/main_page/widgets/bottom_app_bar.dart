import 'package:chemin_du_local/core/main_page/main_page.dart';
import 'package:chemin_du_local/core/main_page/page_item.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class BottomAppBar extends StatelessWidget {
  const BottomAppBar({
    Key? key,
    required this.onSelectedPage,
    required this.currentPageId
  }) : super(key: key);

  final Function(PagesId) onSelectedPage;
  final PagesId currentPageId;

  final List<PagesId> pageIds = const [
    PagesId.dashboard, 
    PagesId.products
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        _buildItem(
          icon: pagesItem[PagesId.dashboard]!.icon,
          label: pagesItem[PagesId.dashboard]!.title
        ),
        _buildItem(
          icon: pagesItem[PagesId.products]!.icon,
          label: pagesItem[PagesId.products]!.title
        ),
      ],
      unselectedItemColor: Palette.colorDark,
      selectedItemColor: Palette.colorPrimary,
      backgroundColor: Theme.of(context).cardColor,
      currentIndex: pageIds.indexOf(currentPageId),
      onTap: (index) => onSelectedPage(pageIds[index]),
    );
  }

  BottomNavigationBarItem _buildItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: label
    );
  }
}