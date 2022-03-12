import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/features/main_page/widgets/bootom_app_bar_item.dart';
import 'package:chemin_du_local/features/main_page/widgets/bottom_app_bar_painter.dart';
import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class BottomAppBar extends StatelessWidget {
  const BottomAppBar({
    Key? key,
    required this.onSelectedPage,
    required this.currentPageIndex,
    required this.pageItems,
  }) : super(key: key);

  final Function(PageItem) onSelectedPage;
  final int currentPageIndex;

  final List<PageItem> pageItems;

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
                onPressed: () => onSelectedPage(pageItems[0]),
                child: Container(
                  width: size.width * 0.17,
                  height: size.width * 0.17,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: Palette.gradientPrimary
                  ),
                  child: Icon(
                    pageItems[0].icon,
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
                BottomAppBarItem(
                  isCurrentItem: currentPageIndex == pageItems[1].index,
                  onSelectedPage: onSelectedPage,
                  pageItem: pageItems[1],
                ),
                BottomAppBarItem(
                  isCurrentItem: currentPageIndex == pageItems[2].index,
                  onSelectedPage: onSelectedPage,
                  pageItem: pageItems[2],
                ),
                SizedBox(width: size.width * 0.2,),
                BottomAppBarItem(
                  isCurrentItem: currentPageIndex == pageItems[3].index,
                  onSelectedPage: onSelectedPage,
                  pageItem: pageItems[3],
                ),
                BottomAppBarItem(
                  isCurrentItem: currentPageIndex == pageItems[4].index,
                  onSelectedPage: onSelectedPage,
                  pageItem: pageItems[4],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}