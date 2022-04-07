import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:flutter/material.dart';

class BasketSchedulesList extends StatelessWidget {
  const BasketSchedulesList({
    Key? key,
    required this.commerce,
    required this.currentDateIndex,
    required this.onIndexChanged,
  }) : super(key: key);

  final Commerce commerce;
  final int currentDateIndex;

  final Function(int) onIndexChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor
          )
        )
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < 9; ++i)
            Flexible(
              child: GestureDetector(
                onTap: () => onIndexChanged(i),
                child: Container(
                  decoration: BoxDecoration(
                    color: i == currentDateIndex ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                    border: Border(
                      bottom: BorderSide(
                        color: Theme.of(context).dividerColor
                      )
                    ) 
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Les horraires
                      Text(
                        "${9+i}:30-${10+i}:30",
                        style: TextStyle(
                          fontWeight: i == currentDateIndex ? FontWeight.bold : FontWeight.normal
                        ),
                      ),
                      
                      // Le bouton choisir
                      Text(
                        "Choisir de créneau",
                        style: i == currentDateIndex 
                          ? const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic
                            )
                          : TextStyle(
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline
                            ),
                      ) 
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}