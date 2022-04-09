import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_form.dart';
import 'package:flutter/material.dart';

class RegistrationStep1 extends StatelessWidget {
  const RegistrationStep1({
    Key? key,
    required this.onTypeChoosed
  }) : super(key: key);

  final Function(String) onTypeChoosed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Je suis", textAlign: TextAlign.center,),
        const SizedBox(height: 10,),

        ClElevatedButton(
          onPressed: () => onTypeChoosed(RegistrationType.storekeeper), 
          child: const Text("un commerçant")
        ),
        const SizedBox(height: 10,),

        ClElevatedButton(
          onPressed: () => onTypeChoosed(RegistrationType.client), 
          child: const Text("un client")
        )
      ],
    );
  }
}