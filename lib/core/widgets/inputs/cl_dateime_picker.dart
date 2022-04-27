import 'package:chemin_du_local/core/widgets/cl_card.dart';
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
    required this.onChanged,
    this.validator,
    this.label,
  }) : super(key: key);

  final DateTimePickerType type;

  final DateTime? initialDate;
  final String? initialValue;
  final DateTime? firstDate;
  final DateTime? lastDate;

  final String? label;

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
          Text(label!, style: const TextStyle(fontSize: 12),),
          const SizedBox(height: 10.0,),
        },
        ClCard(
          padding: EdgeInsets.zero,
          child: DateTimePicker(
            type: type,
            initialDate: initialDate,
            initialValue: initialValue,
            dateMask: 'dd/MM/yyyy hh:mm',
            firstDate: firstDate,
            lastDate: lastDate,
            dateLabelText: "Date",
            timeLabelText: "Heure",
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              fillColor: Theme.of(context).cardColor,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(12.0),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onChanged: onChanged,
            validator: validator,
          )
        ),
      ],
    );
  }
}