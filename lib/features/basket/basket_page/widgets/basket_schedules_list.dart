import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/commerces/models/schedule/schedule.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BasketSchedulesList extends StatelessWidget {
  const BasketSchedulesList({
    Key? key,
    required this.commerce,
    required this.currentDateIndex,
    required this.day,
    required this.onIndexChanged,
  }) : super(key: key);

  final Commerce commerce;
  final int currentDateIndex;

  final DateTime day;

  final Function(int) onIndexChanged;

  @override
  Widget build(BuildContext context) {
    final List<DateTime> hours = [];
    
    if (day.weekday == DateTime.monday) {
      for (final Schedule schedule in (commerce.businessHours?.monday ?? [])) {
        hours.addAll(_halfHours(schedule));
      }
    }

    if (day.weekday == DateTime.tuesday) {
      for (final Schedule schedule in (commerce.businessHours?.tuesday ?? [])) {
        hours.addAll(_halfHours(schedule));
      }
    }

    if (day.weekday == DateTime.wednesday) {
      for (final Schedule schedule in (commerce.businessHours?.wednesday ?? [])) {
        hours.addAll(_halfHours(schedule));
      }
    }

    if (day.weekday == DateTime.thursday) {
      for (final Schedule schedule in (commerce.businessHours?.thursday ?? [])) {
        hours.addAll(_halfHours(schedule));
      }
    }

    if (day.weekday == DateTime.friday) {
      for (final Schedule schedule in (commerce.businessHours?.friday ?? [])) {
        hours.addAll(_halfHours(schedule));
      }
    }

    if (day.weekday == DateTime.saturday) {
      for (final Schedule schedule in (commerce.businessHours?.saturday ?? [])) {
        hours.addAll(_halfHours(schedule));
      }
    }

    if (day.weekday == DateTime.sunday) {
      for (final Schedule schedule in (commerce.businessHours?.sunday ?? [])) {
        hours.addAll(_halfHours(schedule));
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline
          )
        )
      ),
      child: hours.isEmpty
        ? const ClStatusMessage(
          message: "Le commerce n'est pas ouvert ce jours là",
          type: ClStatusMessageType.info,
        )
        : Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildHours(context, hours: hours)
      ),
    );
  }

  List<Widget> _buildHours(BuildContext context, {required List<DateTime> hours}) {
    return [
      for (int i = 0; i < hours.length - 1; ++i)
        Flexible(
          child: GestureDetector(
            onTap: () => onIndexChanged(i),
            child: Container(
              decoration: BoxDecoration(
                color: i == currentDateIndex ? Theme.of(context).colorScheme.primary :  Theme.of(context).colorScheme.surface,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.outline
                  )
                ) 
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Les horraires
                  Text(
                    "${DateFormat("HH:mm").format(hours[i])}-${DateFormat("HH:mm").format(hours[i+1])}",
                    style: TextStyle(
                      fontWeight: i == currentDateIndex ? FontWeight.bold : FontWeight.normal
                    ),
                  ),
                  
                  // Le bouton choisir
                  Text(
                    "Choisir de créneau",
                    style: i == currentDateIndex 
                      ? const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic
                        )
                      : TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline
                        ),
                  ) 
                ],
              ),
            ),
          ),
        )
    ];
  }

  List<DateTime> _halfHours(Schedule schedule) {
    final DateTime openingDate = DateTime.tryParse("19700101T${schedule.opening}") ?? DateTime.now();
    final DateTime closingDate = DateTime.tryParse("19700101T${schedule.closing}") ?? DateTime.now();
    final List<DateTime> result = [];

    while((result.isNotEmpty ? result.last : openingDate).isBefore(closingDate)) {
      if (result.isEmpty) {
        result.add(openingDate);
      }
      else {
        result.add(result.last.add(const Duration(minutes: 30)));
      }
      
      result.add(result.last.add(const Duration(minutes: 30)));
    }

    result.add(closingDate);

    return result;
  }

  int _openingHourFromSchedule(Schedule schedule) {
    return int.parse(schedule.opening.split(":")[0]);
  }

}