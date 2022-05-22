import 'package:chemin_du_local/core/widgets/inputs/cl_dateime_picker.dart';
import 'package:chemin_du_local/features/commerces/models/schedule/schedule.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/schedule_field_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class ScheduleField extends StatefulWidget {
  const ScheduleField({
    Key? key,
    required this.dayString, 
    required this.controller,
  }) : super(key: key);

  final String dayString;

  final ScheduleFieldController controller;

  @override
  State<ScheduleField> createState() => _ScheduleFieldState();
}

class _ScheduleFieldState extends State<ScheduleField> {
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();

    _isOpen = widget.controller.schedules.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // The selector
        Flexible(
          child: Row(
            children: [
              // Le jour
              SizedBox(
                width: 100,
                child: Text(widget.dayString),
              ),

              Switch(
                value: _isOpen, 
                onChanged: (value) {
                  if (value) {
                    widget.controller.addEmptySchedule();
                  }
                  else {
                    widget.controller.clearSchedule();
                  }

                  setState(() {
                    _isOpen = !_isOpen;
                  });
                }
              ),

              Text(_isOpen ? "Ouvert" : "Fermé")
            ],
          ),
        ),
        
        // Les heures
        if (_isOpen) ...{
          for (int i = 0; i < widget.controller.schedules.length; ++i) ...{
            Flexible(
              child: _buildHoursLine(i, widget.controller.schedules[i]),
            ),
            const SizedBox(height: 8,)
          },
          
          if (widget.controller.schedules.last.opening.isNotEmpty && 
              widget.controller.schedules.last.closing.isNotEmpty)
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.controller.addEmptySchedule();
                  });
                }, 
                child: const Text("Ajouter des horaires")
              )
              
        }

      ],
    );
  }

  Widget _buildHoursLine(int index, Schedule schedule) {
    final DateTime openingDate = DateTime.tryParse("19700101T${schedule.opening}") ?? DateTime.now();
    final DateTime closingDate = DateTime.tryParse("19700101T${schedule.closing}") ?? DateTime.now();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: ClDateTimePicker(
            initialDate: openingDate,
            initialValue: schedule.opening,
            type: DateTimePickerType.time,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                widget.controller.setOpening(index, value);
              });
            },
            validator: (value) {
              if (value?.isEmpty ?? true) return "Ne doit pas être vide...";
              return null;
            },
          ),
        ),

        const Text(" - "),

        Flexible(
          child: ClDateTimePicker(
            initialDate: closingDate,
            initialValue: schedule.closing,
            type: DateTimePickerType.time,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                widget.controller.setClosing(index, value);
              });
            },
            validator: (value) {
              if (value?.isEmpty ?? true) return "Ne doit pas être vide...";
              return null;
            },
          ),
        )
      ],
    );
  }
}