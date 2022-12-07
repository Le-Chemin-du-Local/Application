import 'package:chemin_du_local/features/storekeepers/storekeeper_page/edit_dialog/widgets/schedule_field.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/edit_dialog/widgets/schedule_field_controller.dart';
import 'package:flutter/widgets.dart';

class ScheduleForm extends StatelessWidget {
    const ScheduleForm({
      Key? key,
      required this.mondayController,
      required this.tuesdayController,
      required this.wednesdayController,
      required this.thursdayController,
      required this.fridayController,
      required this.saturdayController,
      required this.sundayController,
  }) : super(key: key);

  final ScheduleFieldController mondayController;
  final ScheduleFieldController tuesdayController;
  final ScheduleFieldController wednesdayController;
  final ScheduleFieldController thursdayController;
  final ScheduleFieldController fridayController;
  final ScheduleFieldController saturdayController;
  final ScheduleFieldController sundayController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Lundi
        ScheduleField(
          dayString: "Lundi",
          controller: mondayController,
        ),
        const SizedBox(height: 16,),

        // Mardi
        ScheduleField(
          dayString: "Mardi",
          controller: tuesdayController,
        ),
        const SizedBox(height: 16,),

        // Mercredi
        ScheduleField(
          dayString: "Mercredi",
          controller: wednesdayController,
        ),
        const SizedBox(height: 16,),

        // Jeudi
        ScheduleField(
          dayString: "Jeudi",
          controller: thursdayController,
        ),
        const SizedBox(height: 16,),

        // Vendredi
        ScheduleField(
          dayString: "Vendredi",
          controller: fridayController,
        ),
        const SizedBox(height: 16,),

        // Samedi
        ScheduleField(
          dayString: "Samedi",
          controller: saturdayController,
        ),
        const SizedBox(height: 16,),

        // Dimanche
        ScheduleField(
          dayString: "Dimanche",
          controller: sundayController,
        ),
        const SizedBox(height: 16,),
      ],
    );
  }
}