import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:flutter/material.dart';

class PageSchedulesCard extends StatelessWidget {
  const PageSchedulesCard({
    Key? key,
    required this.schedules
  }) : super(key: key);

  final Map<String, String> schedules;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDay(day: "Lundi", value: schedules["Monday"] ?? "Inconnue"),
          const SizedBox(height: 2,),
          _buildDay(day: "Mardi", value: schedules["Tuesday"] ?? "Inconnue"),
          const SizedBox(height: 2,),
          _buildDay(day: "Mercredi", value: schedules["Wednesday"] ?? "Inconnue"),
          const SizedBox(height: 2,),
          _buildDay(day: "Jeudi", value: schedules["Thursday"] ?? "Inconnue"),
          const SizedBox(height: 2,),
          _buildDay(day: "Vendredi", value: schedules["Friday"] ?? "Inconnue"),
          const SizedBox(height: 2,),
          _buildDay(day: "Samedi", value: schedules["Saturday"] ?? "Inconnue"),
          const SizedBox(height: 2,),
          _buildDay(day: "Dimanche", value: schedules["Sunday"] ?? "Inconnue"),
        ],
      ),
    );
  }

  Widget _buildDay({required String day, required String value}) {
    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 152,
            child: Text(day, style: const TextStyle(fontWeight: FontWeight.bold),),
          ),
          Flexible(child: Text(value),)
        ],
      ),
    );
  }
}