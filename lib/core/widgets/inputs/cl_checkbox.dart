import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:flutter/material.dart';

class ClCheckBox extends StatelessWidget {
  const ClCheckBox({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.text
  }) : super(key: key);


  final bool value;
  final Function(bool?) onChanged;
  
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 24, height: 24,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        Flexible(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Text(
              text, 
              style: ScreenHelper.instance.isMobile 
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context).textTheme.headlineSmall
            ),
          ),
        )
      ],
    );
  }
}