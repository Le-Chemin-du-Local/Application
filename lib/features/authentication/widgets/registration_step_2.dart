import 'package:chemin_du_local/core/widgets/inputs/cl_dateime_picker.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_dropdown.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/place/widgets/address_controller.dart';
import 'package:chemin_du_local/features/place/widgets/address_form.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class RegistrationStep2 extends StatelessWidget {
  const RegistrationStep2({
    Key? key,
    required this.formKey,
    required this.addressController,
    required this.firstNameTextController,
    required this.lastNameTextController,
    required this.gender,
    required this.onGenderChanged,
    required this.initialDate,
    required this.onBirthdateChange,
    required this.onNext,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final AddressController addressController;
  final TextEditingController firstNameTextController;
  final TextEditingController lastNameTextController;

  final String gender;
  final Function(String?) onGenderChanged;

  final DateTime? initialDate;
  final Function(String?) onBirthdateChange;

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
            // Le genre
            ClDropdown<String>(
              label: "Civilité",
              items: const {
                "": "",
                "monsieur": "Monsieur",
                "madame": "Madame",
                "autre": "Autre",
              }, 
              currentValue: gender, 
              onChanged: onGenderChanged, 
              validator: (value) {
                if (value?.isEmpty ?? true) return "Vous devez mettre ventre genre";
                return null;
              }
            ),
            const SizedBox(height: 10,),

            // Le prénom
            ClTextInput(
              controller: firstNameTextController, 
              labelText: "Mon prénom",
              hintText: "Victor",
              validator: (value) {
                if (value.isEmpty) return "Vous devez rentrer un prénom";
                return null;
              },
            ),
            const SizedBox(height: 10,),
          
            // Le nom
            ClTextInput(
              controller: lastNameTextController,
              labelText: "Mon nom",
              hintText: "DENIS",
              validator: (value) {
                if (value.isEmpty) return "Vous devez rentrer un nom";
                return null;
              }
            ),
            const SizedBox(height: 10,),
          
            ClDateTimePicker(
               type: DateTimePickerType.date,
               initialDate: initialDate,
               label: "Date de naissance",
               dateMask: "dd/MM/yyyy",
               firstDate: DateTime(1900),
               lastDate: DateTime.now(),
               initialDatePickerMode: DatePickerMode.year,
               onChanged: onBirthdateChange,
            ),
            const SizedBox(height: 10,),

            AddressForm(
              addressController: addressController,
            ),
            const SizedBox(height: 10,),
          
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