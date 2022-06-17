import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

class ClPhoneInput extends StatelessWidget {
  const ClPhoneInput({
    Key? key,
    this.formKey,
    required this.controller,
    required this.labelText,
    this.focusNode,
    this.hintText,
    this.onSaved,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.invisibleReadOnly = false,
    this.canBeEmpty = false,
  }) : super(key: key);

  final Key? formKey;

  final TextEditingController controller;
  final Function(String)? onSaved;
  final Function(String?)? onChanged;
  final Function()? onTap;

  final FocusNode? focusNode;

  final String? hintText;
  final String labelText;

  final bool readOnly;
  final bool invisibleReadOnly;
  final bool canBeEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(labelText, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 4.0,),
        ClCard(
          padding: EdgeInsets.zero,
          child: TextFormField(
            focusNode: focusNode,
            key: formKey,
            onTap: onTap,
            controller: controller,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              fillColor: (readOnly && !invisibleReadOnly) ? Theme.of(context).disabledColor : Theme.of(context).colorScheme.surface,
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
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: SizedBox(
                    height: 16, width: 16,
                    child: Flag.fromCode(FlagsCode.FR)
                  ),
                ),
              )
            ),
            validator: (value) {
              if ((value?.isEmpty ?? true) && !canBeEmpty) return "Vous devez rentrer un numéro"; 

              // String pattern = r"/^((\+)33|0|0033)[1-9](\d{2}){4}$/g";
              // RegExp phoneRegexp = RegExp(pattern);

              // if (!phoneRegexp.hasMatch(value ?? "")) return "Vous devez rentrer un numéro valide.";

              return null;
            },
            onSaved: onSaved != null ? (value) => onSaved!(value ?? "") : null,
            onChanged: (value) {
              if (onChanged != null) {
                onChanged!(value);
              }
            },
          ),
        ),
      ],
    );
  }
}