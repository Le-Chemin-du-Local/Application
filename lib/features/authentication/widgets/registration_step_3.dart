import 'package:chemin_du_local/core/widgets/inputs/cl_dropdown.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_phone_input.dart';
import 'package:chemin_du_local/features/place/widgets/address_controller.dart';
import 'package:chemin_du_local/features/place/widgets/address_form.dart';
import 'package:flutter/material.dart';

class RegistrationStep3 extends StatelessWidget {
  const RegistrationStep3({
    Key? key, 
    required this.formKey,
    required this.addressController,
    required this.phoneTextController,
    required this.onStoreTypeChanged,
    required this.storeType,
    required this.onNext,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final AddressController addressController;
  final TextEditingController phoneTextController;
  
  final Function(String?) onStoreTypeChanged;
  final String storeType;

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
            // Le type du commerce
            ClDropdown<String>(
              currentValue: storeType,
              label: "Le type",
              items: const {
                "": "",
                "Apiculture": "Apiculture",
                "Boulangerie - Patiserie": "Boulangerie - Patiserie",
                "Boucherie": "Boucherie",
                "Brasserie": "Brasserie",
                "Épicerie": "Épicerie",
                "Maraicher": "Maraicher",
                "Micro-brasserie": "Micro-brasserie",
                "Ostréiculture": "Ostréiculture",
                "Primeur": "Primeur",
              },
              onChanged: onStoreTypeChanged,
              validator: (value) {
                if ((value ?? "").isEmpty) return "Vous devez rentrer un type de commerce";
                return null;
              },
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: () {}, // TODO: afficher un message
              child: Text(
                "Mon commerce n'est pas dans la liste, que faire ?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            const SizedBox(height: 10,),
      
            // l'adresse
            AddressForm(
              addressController: addressController,
            ),
            const SizedBox(height: 10,),

            // Le numéro de téléphone
            ClPhoneInput(
              controller: phoneTextController, 
              labelText: "Numéro de téléphone de mon commerce",
              hintText: "0652809335",
            ),
            const SizedBox(height: 10,),
      
            // Le bouton d'acceptation
            ElevatedButton(
              onPressed: onNext,
              child: const Text("Suivant"),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}