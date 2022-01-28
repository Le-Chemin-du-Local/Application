import 'package:chemin_du_local/core/main_page/main_page.dart';
import 'package:chemin_du_local/core/main_page/page_item.dart';
import 'package:chemin_du_local/core/main_page/widgets/bottom_app_bar_painter.dart';
import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
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
    PagesId.products,
    PagesId.page,
    PagesId.services,
    PagesId.settings
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double height = 70;

    return Container(
      width: size.width,
      height: height,
      color: Colors.transparent,
      child: Stack(
        children: [
          // The shape of the app bar
          CustomPaint(
            size: Size(size.width, height),
            painter: BottomAppBarPainter(),
          ),

          // The middle button
          Center(
            heightFactor: 0.7,
            child: SizedBox(
              width: size.width * 0.17,
              height: size.width * 0.17,
              child: FloatingActionButton(
                onPressed: () => onSelectedPage(PagesId.page),
                child: Container(
                  width: size.width * 0.17,
                  height: size.width * 0.17,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: Palette.gradientPrimary
                  ),
                  child: const Icon(
                    CLIcons.mapage,
                    color: Palette.colorWhite,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),

          // The other items
          SizedBox(
            width: size.width,
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItem(context, pageId: PagesId.dashboard),
                _buildItem(context, pageId: PagesId.products),
                SizedBox(width: size.width * 0.2,),
                _buildItem(context, pageId: PagesId.services),
                _buildItem(context, pageId: PagesId.settings),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, {required PagesId pageId}) {
    final String text = pagesItem[pageId]?.title ?? "Inconnue";
    final IconData icon = pagesItem[pageId]?.icon ?? CLIcons.accueil;

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  icon,
                  color: (currentPageId == pageId) ? Theme.of(context).primaryColor : Palette.colorDarkGrey,
                ),
                onPressed: () {
                  onSelectedPage(pageId);
                },
              ),
            ),
            const SizedBox(
              height: 1,
            ),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: (currentPageId == pageId) ? Theme.of(context).primaryColor : Palette.colorDarkGrey,
                  fontSize: 12
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}

// class BottomAppBar extends StatelessWidget {
//   const BottomAppBar({
//     Key? key,
//     required this.onSelectedPage,
//     required this.currentPageId
//   }) : super(key: key);

//   final Function(PagesId) onSelectedPage;
//   final PagesId currentPageId;

//   final List<PagesId> pageIds = const [
//     PagesId.dashboard, 
//     PagesId.products
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: [
//         _buildItem(
//           icon: pagesItem[PagesId.dashboard]!.icon,
//           label: pagesItem[PagesId.dashboard]!.title
//         ),
//         _buildItem(
//           icon: pagesItem[PagesId.products]!.icon,
//           label: pagesItem[PagesId.products]!.title
//         ),
//       ],
//       unselectedItemColor: Palette.colorDark,
//       selectedItemColor: Palette.colorPrimary,
//       backgroundColor: Theme.of(context).cardColor,
//       currentIndex: pageIds.indexOf(currentPageId),
//       onTap: (index) => onSelectedPage(pageIds[index]),
//     );
//   }

//   BottomNavigationBarItem _buildItem({
//     required IconData icon,
//     required String label,
//   }) {
//     return BottomNavigationBarItem(
//       icon: Icon(icon),
//       label: label
//     );
//   }
// }