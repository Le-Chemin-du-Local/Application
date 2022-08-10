import 'package:flutter/material.dart';

class ButtonsTabBar extends StatelessWidget {
  const ButtonsTabBar({
    Key? key,
    required this.currentIndex,
    required this.titles,
    required this.onIndexChanged,
  }) : assert(currentIndex < titles.length && currentIndex >= 0), super(key: key);

  final int currentIndex;
  final List<Widget> titles;

  final Function(int) onIndexChanged;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 54),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 8,),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          if (index == currentIndex) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium,
                elevation: 0,
                primary: Theme.of(context).colorScheme.secondaryContainer,
                onPrimary: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                )
              ),
              onPressed: () => onIndexChanged(index), 
              child: titles[index]
            );
          }
    
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium,
                elevation: 0,
                primary: Theme.of(context).colorScheme.secondary,
                padding: const EdgeInsets.all(12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
                ),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.secondary
                )
            ),
            onPressed: () => onIndexChanged(index), 
            child: titles[index]
          );
        },
      ),
    );
  }
}