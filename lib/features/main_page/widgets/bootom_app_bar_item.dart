import 'package:chemin_du_local/features/basket/riverpod/basket_controller.dart';
import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomAppBarItem extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final String text = pageItem?.title ?? "Inconnue";
    final IconData icon = pageItem?.icon ?? Icons.question_mark;

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (pageItem != null) {
            onSelectedPage(pageItem!);
          }
        },
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40, width: 40,
                    child: Icon(
                      icon,
                      size: 32,
                      color: isCurrentItem ? Theme.of(context).colorScheme.secondary : Palette.colorDarkGrey,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Flexible(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isCurrentItem ? Theme.of(context).colorScheme.secondary : Palette.colorDarkGrey,
                        fontSize: 9
                      ),
                    ),
                  )
                ]
              ),
            ),
        
            if (pageItem?.isBasket ?? false)
            Positioned(
              top: 0, right: 0,
              child: ref.watch(basketControllerProvider).basket.when(
                data: (data) => data.count <= 0 ? Container() : Container(
                  width: 18, height: 18,
                  decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(9.0),
                  ),
                  child: Center(
                        child: Text(
                          data.count.toString(),
                          style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSecondary),
                        ),
                  ),
                ),
                loading: () => Container(),
                error: (error, stackTrace) => Container()
              ),
            )
          ],
        ),
      ),
    );
  }
}