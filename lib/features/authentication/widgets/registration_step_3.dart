import 'package:chemin_du_local/core/widgets/inputs/cl_checkbox.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dropdown.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_phone_input.dart';
import 'package:chemin_du_local/features/place/models/address/address.dart';
import 'package:chemin_du_local/features/place/widgets/address_controller.dart';
import 'package:chemin_du_local/features/place/widgets/address_form.dart';
import 'package:flutter/material.dart';

class RegistrationStep3 extends StatefulWidget {
  const RegistrationStep3({
    Key? key, 
    required this.formKey,
    required this.addressController,
    required this.storeKeeperAddress,
    required this.phoneTextController,
    required this.onStoreTypeChanged,
    required this.storeType,
    required this.onNext,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final AddressController addressController;
  final Address storeKeeperAddress;

  final TextEditingController phoneTextController;
  
  final Function(String?) onStoreTypeChanged;
  final String storeType;

  final Function() onNext;

  @override
  State<RegistrationStep3> createState() => _RegistrationStep3State();
}

class _RegistrationStep3State extends State<RegistrationStep3> {
  bool _isAddressTheSame = false;

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
            // Le type du commerce
            ClDropdown<String>(
              currentValue: widget.storeType,
              label: "Le type",
              items: const {
                "": "",
                "Apiculture": "Apiculture",
                "Boulangerie - Pâtisserie": "Boulangerie - Pâtisserie",
                "Boucherie": "Boucherie",
                "Épicerie": "Épicerie",
                "Fromagerie": "Fromagerie",
                "Maraicher": "Maraicher",
                "Micro-brasserie": "Micro-brasserie",
                "Ostréiculture": "Ostréiculture",
                "Primeur": "Primeur",
                "Pas de type": "Mon type n'est pas dans la liste"
              },
              onChanged: widget.onStoreTypeChanged,
              validator: (value) {
                if ((value ?? "").isEmpty) return "Vous devez rentrer un type de commerce";
                return null;
              },
            ),
            const SizedBox(height: 10,),
      
            // l'adresse
            ClCheckBox(
              value: _isAddressTheSame, 
              onChanged: (value) {
                setState(() {
                  _isAddressTheSame = value ?? false;
                });
              }, 
              text: "L'adresse du commerce est la même que mon adresse."
            ),
            const SizedBox(height: 10,),
            
            if (!_isAddressTheSame) ...{
              AddressForm(
                addressController: widget.addressController,
              ),
              const SizedBox(height: 10,),
            },

            // Le numéro de téléphone
            ClPhoneInput(
              controller: widget.phoneTextController, 
              labelText: "Numéro de téléphone de mon commerce",
              hintText: "0652809335",
            ),
            const SizedBox(height: 10,),
      
            // Le bouton d'acceptation
            ElevatedButton(
              onPressed: () {
                if (_isAddressTheSame) {
                  widget.addressController.address = widget.storeKeeperAddress.copyWith();
                }

                widget.onNext();
              },
              child: const Text("Suivant"),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}