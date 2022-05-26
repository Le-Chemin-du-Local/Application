import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:flutter/material.dart';

class PickerCategoryButton extends StatefulWidget {
  const PickerCategoryButton({
    Key? key,
    required this.name,
    required this.isSelected,
    required this.onTap
  }) : super(key: key);

  final String name;

  final bool isSelected;
  final Function(bool) onTap;

  @override
  State<PickerCategoryButton> createState() => _PickerCategoryButtonState();
}

class _PickerCategoryButtonState extends State<PickerCategoryButton> {
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();

    _isSelected = widget.isSelected;
  }

  @override
  void didUpdateWidget(covariant PickerCategoryButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    _isSelected = widget.isSelected;
  }

  @override
  Widget build(BuildContext context) {
    const double width = 205;
    const double height = 205;

    final Color textColor = _isSelected 
      ? Theme.of(context).colorScheme.secondary
      : Theme.of(context).colorScheme.onSurface;

    return InkWell(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
        });

        widget.onTap(_isSelected);
      },
      child: ClCard(
        padding: const EdgeInsets.all(4),
        width: width,
        height: height,
        borderColor: _isSelected ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.surface,
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color:  Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                kCategorieLogo[widget.name], 
                color: textColor,
                size: 102,
              ),
              Text(
                widget.name,
                style: TextStyle(color: textColor),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}