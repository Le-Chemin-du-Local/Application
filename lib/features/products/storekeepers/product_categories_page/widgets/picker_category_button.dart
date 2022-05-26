import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/gradient_icon.dart';
import 'package:chemin_du_local/core/widgets/gradient_text.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/theme/palette.dart';
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
        backgroundGradient: _isSelected ? Palette.gradientPrimary : null,
        backgroundColor: _isSelected ? null :  Theme.of(context).colorScheme.surface,
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
              if (_isSelected) ...{
                GradientIcon(kCategorieLogo[widget.name], gradient: Palette.gradientPrimary, size: 102,),
                GradientText(
                  widget.name, 
                  textAlign: TextAlign.center,
                  gradient: Palette.gradientPrimary,
                )
              }
              else ...{
                Icon(kCategorieLogo[widget.name], size: 102,),
                Text(widget.name, textAlign: TextAlign.center,)
              }
            ],
          ),
        ),
      ),
    );
  }
}