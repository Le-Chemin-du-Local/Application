import 'package:chemin_du_local/features/basket/riverpod/basket_controller.dart';
import 'package:chemin_du_local/features/main_page/page_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuDrawerItem extends ConsumerWidget {
  const MenuDrawerItem({
    Key? key,
    required this.item, 
    this.isActive = false,
    this.isMinimified = false
  }) : super(key: key);

  final PageItem item;
  final bool isActive;
  final bool isMinimified;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Container(
          // height: 100,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).colorScheme.primary.withOpacity(0.1) :  Theme.of(context).colorScheme.surface,
            border: !isActive ? null : Border(
              left: BorderSide(width: 4, color: Theme.of(context).colorScheme.primary)
            )
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: isActive 
              ? Theme.of(context).colorScheme.primary 
              : Theme.of(context).textTheme.bodyText2!.color,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    item.icon, 
                    size: 20, 
                    color: isActive 
                    ? Theme.of(context).colorScheme.primary 
                    : Theme.of(context).textTheme.bodyText2!.color,
                  ),
                ),
                if (!isMinimified) ...{
                  Expanded(
                    flex: 8,
                    child: Text(item.title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                  ),
                  if (item.isBasket) 
                    Expanded(
                      child: _buildBasketCount(context, ref)
                    )
                }
              ],
            ),
          ),
        ),
        if (isMinimified && item.isBasket)
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary
              ),
              child: Center(
                child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                  child: _buildBasketCount(context, ref),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _buildBasketCount(BuildContext context, WidgetRef ref) {
    return ref.watch(basketControllerProvider).basket.when(
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
    );
  }
}