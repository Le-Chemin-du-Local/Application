
import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ClTextInput extends StatefulWidget {
  const ClTextInput({
    Key? key,
    this.formKey,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    required this.controller,
    required this.validator,
    required this.labelText,
    this.focusNode,
    this.suffixIcon,
    this.hintText,
    this.maxLines = 1,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.invisibleReadOnly = false,
    this.maxLenght,
    this.maxLengthEnforcement,
  }) : super(key: key);

  final Key? formKey;

  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String)? validator;
  final Function(String)? onSaved;
  final Function(String?)? onChanged;
  final Function()? onTap;

  final FocusNode? focusNode;

  final int? maxLenght;
  final MaxLengthEnforcement? maxLengthEnforcement;

  final IconData? suffixIcon;
  final String? hintText;
  final String labelText;

  final TextInputType inputType;
  final int maxLines;

  final bool readOnly;
  final bool invisibleReadOnly;

  @override 
  _ClTextInput createState() => _ClTextInput();
}

class _ClTextInput extends State<ClTextInput> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();

    _obscureText = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant ClTextInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.labelText.isNotEmpty) ...{
          Text(
            widget.labelText,
            style: ScreenHelper.instance.isMobile 
              ? Theme.of(context).textTheme.titleMedium
              : Theme.of(context).textTheme.headlineSmall
          ),
          const SizedBox(height: 4.0,),
        },
        TextFormField(
          focusNode: widget.focusNode,
          readOnly: widget.readOnly,
          enabled: !widget.readOnly,
          key: widget.formKey,
          onTap: widget.onTap,
          obscureText: _obscureText,
          controller: widget.controller,
          keyboardType: widget.inputType,
          maxLength: widget.maxLenght,
          maxLengthEnforcement: widget.maxLengthEnforcement,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            fillColor: (widget.readOnly && !widget.invisibleReadOnly) ? Theme.of(context).disabledColor : Theme.of(context).colorScheme.surface,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : !widget.obscureText ? null : InkWell(
              onTap: _textVisibilityUpdated,
              child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
            )
          ),
          validator: widget.validator == null ? null : (value) => widget.validator!(value ?? ""),
          onSaved: widget.onSaved != null ? (value) => widget.onSaved!(value ?? "") : null,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          }
        ),
      ],
    );
  }

  void _textVisibilityUpdated() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}