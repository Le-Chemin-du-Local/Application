import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_address_input.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dropdown.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:flutter/widgets.dart';

class RegistrationStep3 extends StatelessWidget {
  const RegistrationStep3({
    Key? key, 
    required this.formKey,
    required this.storeNameController,
    required this.addressTextController, 
    required this.onStoreTypeChanged,
    required this.storeType,
    required this.onNext,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final TextEditingController storeNameController;
  final TextEditingController addressTextController;
  
  final Function(String?) onStoreTypeChanged;
  final String storeType;

  final Function() onNext;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Le nom du commerce
          ClTextInput(
            controller: storeNameController,
            labelText: "Le nom de mon commerce",
            hintText: "La Bizhh",
            validator: (value) {
              if (value.isEmpty) return "Vous devez rentrer le nom de votre commerce";
              return null;
            },
          ),
          const SizedBox(height: 10,),

          // Le type du commerce
          ClDropdown<String>(
            currentValue: storeType,
            label: "Le type",
            items: const {
              "": "",
              "Epicerie": "Epicerie",
              "Brasserie": "Brasserie",
              "Ostriculture": "Ostriculture",
              "Autre": "Autre",
            },
            onChanged: onStoreTypeChanged,
            validator: (value) {
              if ((value ?? "").isEmpty) return "Vous devez rentrer un type de commerce";
              return null;
            },
          ),
          const SizedBox(height: 10,),

          // l'adresse
          ClAddressInput(
            addressTextController: addressTextController,
            onSelected: (value) {},
          ),
          const SizedBox(height: 10,),

          // Le bouton d'acceptation
          ClElevatedButton(
            onPressed: onNext,
            child: const Text("Suivant"),
          )
        ],
      ),
    );
  }
}