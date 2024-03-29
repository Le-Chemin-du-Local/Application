import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class ClDateTimePicker extends StatelessWidget {
  const ClDateTimePicker({
    Key? key,
    this.type = DateTimePickerType.date,
    this.initialDate,
    this.initialValue,
    this.firstDate,
    this.lastDate,
    this.initialDatePickerMode,
    required this.onChanged,
    this.validator,
    this.label,
    this.dateMask = 'dd/MM/yyyy hh:mm',
  }) : super(key: key);

  final DateTimePickerType type;

  final DateTime? initialDate;
  final String? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;

  final DatePickerMode? initialDatePickerMode;

  final String? label;
  final String dateMask;

  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null) ...{
          // Text(label!.toUpperCase(), style: const TextStyle(color: Colors.black54, fontSize: 12),),
          Text(
            label!, 
            style: ScreenHelper.instance.isMobile 
              ? Theme.of(context).textTheme.titleMedium
              : Theme.of(context).textTheme.headlineSmall
          ),
          const SizedBox(height: 10.0,),
        },
        DateTimePicker(
          type: type,
          initialDate: initialDate,
          initialValue: initialValue,
          dateMask: dateMask,
          firstDate: firstDate,
          lastDate: lastDate,
          dateLabelText: "Date",
          timeLabelText: "Heure",
          initialDatePickerMode: initialDatePickerMode,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            fillColor: Theme.of(context).colorScheme.surface,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(12.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}