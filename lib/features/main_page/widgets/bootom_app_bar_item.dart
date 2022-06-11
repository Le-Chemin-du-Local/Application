import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class BottomAppBarItem extends StatelessWidget {
  const BottomAppBarItem({
    Key? key,
    required this.pageItem, 
    required this.onSelectedPage,
    required this.isCurrentItem,
  }) : super(key: key);

  final PageItem? pageItem;
  final Function(PageItem) onSelectedPage;

  final bool isCurrentItem;

  @override
  Widget build(BuildContext context) {
    final String text = pageItem?.title ?? "Inconnue";
    final IconData icon = pageItem?.icon ?? Icons.question_mark;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          if (pageItem != null) {
            onSelectedPage(pageItem!);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Icon(
                  icon,
                  size: 26,
                  color: isCurrentItem ? Theme.of(context).colorScheme.secondary : Palette.colorDarkGrey,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isCurrentItem ? Theme.of(context).colorScheme.secondary : Palette.colorDarkGrey,
                    fontSize: 9
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }
}