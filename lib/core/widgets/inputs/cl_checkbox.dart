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
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: Theme.of(context).colorScheme.primary,
        ),
        Flexible(child: Text(text, style: Theme.of(context).textTheme.caption)),
      ],
    );
  }
}