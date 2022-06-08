import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class ClQuantityPicker extends StatelessWidget {
  const ClQuantityPicker({
    Key? key,
    required this.currentValue, 
    this.minValue, 
    this.maxValue, 
    this.onChanged
  }) : super(key: key);

  final int currentValue;

  final int? minValue;
  final int? maxValue;

  final Function(int)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Bouton -
        _buildControle(context, 
          icon: Icons.remove, 
          onTap: (minValue != null && currentValue <= minValue!) ? null : () { 
            if (onChanged != null) onChanged!(currentValue - 1);
          }
        ),
        const SizedBox(width: 4,),

        // La valeur
        Flexible(child: Text(currentValue.toString())),
        const SizedBox(width: 4,),

        _buildControle(context, 
          icon: Icons.add, 
          onTap: (maxValue != null && currentValue >= maxValue!) ? null : () { 
            if (onChanged != null) onChanged!(currentValue + 1);
          }
        )
      ],
    );
  }

  Widget _buildControle(BuildContext context, {
    required IconData icon,
    required Function()? onTap
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: onTap != null
          ? Theme.of(context).colorScheme.secondary
          : Theme.of(context).disabledColor
      ),
      width: 20, height: 20,
      child: Center(
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(icon, size: 12, color: Palette.colorWhite,),
          alignment: Alignment.center,
          onPressed: onTap,
          splashRadius: 10,      
        ),
      ),
    );
  } 
}