import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:flutter/material.dart';

class RegistrationStepPassword extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClTextInput(
              controller: passwordTextController,
              obscureText: true,
              labelText: "Mon mot de passe",
              hintText: "**********",
              validator: (value) {
                if (value.isEmpty) return "Vous devez choisir un mot de passe";
                return null;
              },
            ),
            const SizedBox(height: 10,),
      
            ClTextInput(
              controller: passwordConfirmTextController,
              obscureText: true,
              labelText: "Confirmer mon mot de passe",
              hintText: "**********",
              validator: (value) {
                if (value != passwordTextController.text) return "Le mot de passe et la confirmation ne correspondent pas";
                return null;
              } 
            ),
            const SizedBox(height: 10,),
      
            ClCheckBox(
              text: "En cliquant sur J’accepte, je suis d’accord avec la Politique de confidentialité et les Termes de services",
              onChanged: onConditionAcceptationChanged,
              value: hasAcceptedConditions,
            ),
            const SizedBox(height: 10,),
      
            ElevatedButton(
              onPressed: onNext,
              child: const Text("Créer mon compte",)
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}