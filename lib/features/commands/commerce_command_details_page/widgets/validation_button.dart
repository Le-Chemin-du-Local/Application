import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:slidable_button/slidable_button.dart';

class ValidationButton extends StatelessWidget {
  const ValidationButton({
    Key? key,
    this.onValidate
  }) : super(key: key);

  final Function()? onValidate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:  Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(45.0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0c000000),
            offset: Offset(0.0, 2.0),
            blurRadius: 12.0,
            // spreadRadius: 1.0
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: SlidableButton(
        // width: MediaQuery.of(context).size.width,
        borderRadius: BorderRadius.circular(32),
        buttonWidth: 64,
        height: 64,
        isRestart: true,
        label: const Icon(
          Icons.chevron_right, 
          color: Palette.colorWhite,
          size: 42,
        ),
        child: Row(
          children: [
            const SizedBox(width: 72,),
            Expanded(
              child: Center(
                child: Text(onValidate != null 
                  ? "Bouton à swiper par le commerçant"
                  : "Il n’est pas encore l’heure de la collecte !")
              ),
            ),
          ],
        ),
        color:  Theme.of(context).colorScheme.surface,
        buttonColor: Theme.of(context).colorScheme.secondary,
        onChanged: onValidate == null ? null : (position) {
          if (position == SlidableButtonPosition.right) {
            onValidate!();
          }
        },
      ),
    );
  }
}