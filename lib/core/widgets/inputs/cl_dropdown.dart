import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:flutter/material.dart';

class ClDropdown<T> extends StatelessWidget {
  const ClDropdown({
    Key? key,
    required this.items, 
    required this.currentValue, 
    required this.onChanged,
    required this.validator,
    this.label,
  }) : super(key: key);

  final Map<T, String> items;
  final T currentValue;

  final String? label;

  final Function(T?) onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...{
          // Text(label!.toUpperCase(), style: const TextStyle(color: Colors.black54, fontSize: 12),),
          Text(label!, style: Theme.of(context).textTheme.titleMedium,),
          const SizedBox(height: 4.0,),
        },
        ClCard(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          borderColor: Theme.of(context).colorScheme.outline,
          child: DropdownButtonFormField<T>(
            value: currentValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 32,
            // underline: Container(),
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero
            ),
            isExpanded: true,
            onChanged: onChanged,
            validator: validator,
            items: [
              for (final key in items.keys) 
                DropdownMenuItem(
                  value: key,
                  child: Text(items[key] ?? "Uknonw"),
                )
            ],
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
          ),
        ),
      ],
    );
  }
}