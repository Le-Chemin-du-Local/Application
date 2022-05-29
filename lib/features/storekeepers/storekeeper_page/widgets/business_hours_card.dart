import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commerces/models/business_hours/business_hours.dart';
import 'package:chemin_du_local/features/commerces/models/schedule/schedule.dart';
import 'package:flutter/widgets.dart';

class BusinessHoursCard extends StatelessWidget {
  const BusinessHoursCard({
    Key? key,
    required this.businessHours
  }) : super(key: key);

  final BusinessHours? businessHours;

  @override
  Widget build(BuildContext context) {
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
    
    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDay(day: "Lundi", value: businessHours?.monday ?? []),
          const SizedBox(height: 2,),
          _buildDay(day: "Mardi", value: businessHours?.tuesday ?? []),
          const SizedBox(height: 2,),
          _buildDay(day: "Mercredi", value: businessHours?.wednesday ?? []),
          const SizedBox(height: 2,),
          _buildDay(day: "Jeudi", value: businessHours?.thursday ?? []),
          const SizedBox(height: 2,),
          _buildDay(day: "Vendredi", value: businessHours?.friday ?? []),
          const SizedBox(height: 2,),
          _buildDay(day: "Samedi", value: businessHours?.saturday ?? []),
          const SizedBox(height: 2,),
          _buildDay(day: "Dimanche", value: businessHours?.sunday ?? []),
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
    return (businessHours?.monday?.isEmpty ?? true) &&
           (businessHours?.tuesday?.isEmpty ?? true) &&
           (businessHours?.wednesday?.isEmpty ?? true) &&
           (businessHours?.thursday?.isEmpty ?? true) &&
           (businessHours?.friday?.isEmpty ?? true) &&
           (businessHours?.saturday?.isEmpty ?? true) &&
           (businessHours?.sunday?.isEmpty ?? true);
  }
}