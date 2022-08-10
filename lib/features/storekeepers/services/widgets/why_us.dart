import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:flutter/material.dart';

class WhyUs extends StatelessWidget {
  const WhyUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Pourquoi nous choisir ?",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w500
          ),
        ),
        const SizedBox(height: 20,),

        _buildRow(context, Icons.bolt, "Tarif attractif"),
        _buildRow(context, CLIcons.drapeauBreton, "Entreprise 100% bretonne"),
        _buildRow(context, Icons.chat_outlined, "Accompagnement personnalisé"),
      ],
    );
  }

  Widget _buildRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 40,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 4,),

        Flexible(
          child: Text(text, style: Theme.of(context).textTheme.headlineSmall,)
        )
      ],
    );
  }
}