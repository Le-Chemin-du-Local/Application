import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/helpers/screen_helper.dart';

class RegistrationStepPassword extends StatefulWidget {
  const RegistrationStepPassword({
    Key? key,
    required this.formKey,
    required this.passwordTextController,
    required this.passwordConfirmTextController,
    required this.onConditionAcceptationChanged,
    required this.hasAcceptedConditions,
    required this.onNext,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  
  final TextEditingController passwordTextController;
  final TextEditingController passwordConfirmTextController;

  final Function(bool?) onConditionAcceptationChanged;
  final bool hasAcceptedConditions;

  final Function() onNext;

  @override
  State<RegistrationStepPassword> createState() => _RegistrationStepPasswordState();
}

class _RegistrationStepPasswordState extends State<RegistrationStepPassword> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClTextInput(
              controller: widget.passwordTextController,
              obscureText: true,
              labelText: "Mon mot de passe",
              hintText: "**********",
              validator: (value) {
                if (value.isEmpty) return "Vous devez choisir un mot de passe";
                if (!RegExp(r"(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])\w+").hasMatch(value)) {
                  return "Les critères ne sont pas respéctés";
                }
                return null;
              },
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 10,),
      
            ClTextInput(
              controller: widget.passwordConfirmTextController,
              obscureText: true,
              labelText: "Confirmer mon mot de passe",
              hintText: "**********",
              validator: (value) {
                if (value != widget.passwordTextController.text) return "Le mot de passe et la confirmation ne correspondent pas";
                return null;
              } 
            ),
            const SizedBox(height: 20,),

            // La liste des confirmations
            Text(
              "Au moins 8 caractères",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: widget.passwordTextController.text.length >= 8 
                  ? Palette.colorSuccess 
                  : Theme.of(context).colorScheme.onBackground
              ),
            ),
            const SizedBox(height: 10,),
            
            Text(
              "Au moins 1 lettre majuscule",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: RegExp(r"(?=.*[A-Z])\w+").hasMatch(widget.passwordTextController.text) 
                  ? Palette.colorSuccess 
                  : Theme.of(context).colorScheme.onBackground
              ),
            ),
            const SizedBox(height: 10,),

            Text(
              "Au moins 1 chiffre",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: RegExp(r"(?=.*[0-9])\w+").hasMatch(widget.passwordTextController.text) 
                  ? Palette.colorSuccess 
                  : Theme.of(context).colorScheme.onBackground
              ),
            ),
            const SizedBox(height: 20,),
      
            // La case de politique de confidentialitée
            ClCheckBox(
              child: RichText(
                text: TextSpan(
                  style: ScreenHelper.instance.isMobile 
                    ? Theme.of(context).textTheme.titleMedium
                    : Theme.of(context).textTheme.headlineSmall,
                  text: "En cliquant sur J’accepte, je suis d’accord avec la ",
                  children: [
                    TextSpan(
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      recognizer: TapGestureRecognizer()..onTap = () => launchUrl(
                        Uri.parse(kPolitiqueConfidentialiteUrl),
                        mode: LaunchMode.externalApplication
                      ),
                      text: "Politique de confidentialité.",
                    )
                  ]
                )
              ),
              onChanged: widget.onConditionAcceptationChanged,
              value: widget.hasAcceptedConditions,
            ),
            const SizedBox(height: 20,),
      
            // Le bouton de validation
            ElevatedButton(
              onPressed: widget.onNext,
              child: const Text("Créer mon compte",)
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}