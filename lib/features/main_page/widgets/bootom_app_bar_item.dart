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
                  color: isCurrentItem ? Theme.of(context).primaryColor : Palette.colorDarkGrey,
                ),
                onPressed: () {
                  if (pageItem != null) {
                    onSelectedPage(pageItem!);
                  }
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
                  color: isCurrentItem ? Theme.of(context).primaryColor : Palette.colorDarkGrey,
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