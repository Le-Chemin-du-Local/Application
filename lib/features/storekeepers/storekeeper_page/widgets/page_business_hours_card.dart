import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commerces/models/schedule/schedule.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/schedule_field.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/schedule_field_controller.dart';
import 'package:flutter/material.dart';

class PageBusinessHoursCard extends StatelessWidget {
  const PageBusinessHoursCard({
    Key? key,
    required this.mondayController,
    required this.tuesdayController,
    required this.wednesdayController,
    required this.thursdayController,
    required this.fridayController,
    required this.saturdayController,
    required this.sundayController,
    required this.isEditing,
  }) : super(key: key);

  final ScheduleFieldController mondayController;
  final ScheduleFieldController tuesdayController;
  final ScheduleFieldController wednesdayController;
  final ScheduleFieldController thursdayController;
  final ScheduleFieldController fridayController;
  final ScheduleFieldController saturdayController;
  final ScheduleFieldController sundayController;

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return _buildForm();
    } 

    if (_isEmpty()) {
      return const ClCard(
        height: 300,
        child: Opacity(
          opacity: 0.4,
          child: Center(
            child: Text("Les horaires d'ouverture de votre commerce"),
          ),
        ),
      );
    }

    return _buildContent();   
  }

  Widget _buildForm() {
    return ClCard(
      child: Column(
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
            dayString: "Thursay",
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
      ),
    );
  }

  Widget _buildContent() {
     return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDay(day: "Lundi", value: mondayController.schedules),
          const SizedBox(height: 2,),
          _buildDay(day: "Mardi", value: tuesdayController.schedules),
          const SizedBox(height: 2,),
          _buildDay(day: "Mercredi", value: wednesdayController.schedules),
          const SizedBox(height: 2,),
          _buildDay(day: "Jeudi", value: thursdayController.schedules),
          const SizedBox(height: 2,),
          _buildDay(day: "Vendredi", value: fridayController.schedules),
          const SizedBox(height: 2,),
          _buildDay(day: "Samedi", value: saturdayController.schedules),
          const SizedBox(height: 2,),
          _buildDay(day: "Dimanche", value: sundayController.schedules),
        ],
      ),
    );
  }

  Widget _buildDay({required String day, required List<Schedule> value}) {
    String hoursString = "Fermé";

    if (value.isNotEmpty) {
      hoursString = "${value[0].opening} - ${value[0].closing}";

      if (value.length > 1) {
        for (int i = 1; i < value.length; ++i) {
          hoursString += " / ${value[i].opening} - ${value[i].closing}";
        } 
      }
    }

    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 152,
            child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold),),
          ),
          Flexible(child: Text(hoursString.replaceAll(":", "h")),)
        ],
      ),
    );
  }

  bool _isEmpty() {
    return mondayController.schedules.isEmpty 
      && tuesdayController.schedules.isEmpty
      && wednesdayController.schedules.isEmpty
      && thursdayController.schedules.isEmpty
      && fridayController.schedules.isEmpty
      && saturdayController.schedules.isEmpty
      && sundayController.schedules.isEmpty;
  }
}