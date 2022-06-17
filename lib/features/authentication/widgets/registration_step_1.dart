import 'package:chemin_du_local/core/widgets/inputs/cl_phone_input.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_form.dart';
import 'package:flutter/material.dart';

class RegistrationStep1 extends StatefulWidget {
  const RegistrationStep1({
    Key? key,
    required this.onCompleted,
    required this.formKey,
    required this.emailTextController,
    required this.phoneTextController,
    required this.storeNameTextController,
    required this.storeSiretTextController,
  }) : super(key: key);

  final Function(String) onCompleted;

  final GlobalKey<FormState> formKey;

  final TextEditingController emailTextController;
  final TextEditingController phoneTextController;
  final TextEditingController storeNameTextController;
  final TextEditingController storeSiretTextController;

  @override
  State<RegistrationStep1> createState() => _RegistrationStep1State();
}

class _RegistrationStep1State extends State<RegistrationStep1> {
  bool _isStorekeeper = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClTextInput(
              controller: widget.emailTextController,
              labelText: "Mon email",
              hintText: "marie.dupont@mail.com",
              inputType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) return "Vous devez rentrer un mail";
                return null;
              },
            ),
            const SizedBox(height: 10,),
          
            ClPhoneInput(
              controller: widget.phoneTextController,
              labelText: "Mon numéro de téléphone",
              hintText: "0652809335",
            ),
            const SizedBox(height: 10,),
          
            SwitchListTile(
              value: _isStorekeeper, 
              title: const Text("Je suis commerçant"),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              onChanged: (value) {
                setState(() {
                  _isStorekeeper = value;
                });
              }
            ),
      
            if (_isStorekeeper) ...{
              const SizedBox(height: 10,),
              // Le nom du commerce
              ClTextInput(              
                controller: widget.storeNameTextController,
                labelText: "Nom du commerce",
                hintText: "La Bizhh",
                validator: (value) {
                  if (value.isEmpty) return "Vous devez rentrer le nom de votre commerce";
                  return null;
                },
              ),
              // ignore: equal_elements_in_set
              const SizedBox(height: 10,),
      
              // Le numéro de SIRET du commerce
              ClTextInput(
                controller: widget.storeSiretTextController,
                labelText: "Numéro de SIRET",
                hintText: "90804680800014",
                validator: (value) {
                  if (value.isEmpty) return "Vous devez rentrer un SIRET";
                  return null;
                },
              )
            },
      
            const SizedBox(height: 20,),
          
            ElevatedButton(
              onPressed: () => widget.onCompleted(
                _isStorekeeper ? RegistrationType.storekeeper : RegistrationType.client
              ),
              child: const Text("Suivant")
            )
          ],
        ),
      ),
    );
  }
}