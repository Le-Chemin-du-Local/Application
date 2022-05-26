import 'package:chemin_du_local/core/widgets/inputs/cl_dateime_picker.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_phone_input.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class RegistrationStep2 extends StatelessWidget {
  const RegistrationStep2({
    Key? key,
    required this.formKey,
    required this.firstNameTextController,
    required this.lastNameTextController,
    required this.emailTextController,
    required this.phoneTextController,
    required this.initialDate,
    required this.onBirthdateChange,
    required this.onNext,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  final TextEditingController firstNameTextController;
  final TextEditingController lastNameTextController;
  final TextEditingController emailTextController;
  final TextEditingController phoneTextController;

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
               firstDate: DateTime(1900),
               lastDate: DateTime.now(),
               onChanged: onBirthdateChange,
            ),
            const SizedBox(height: 10,),
          
            ClTextInput(
              controller: emailTextController,
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
              controller: phoneTextController,
              labelText: "Mon numéro de téléphone",
              hintText: "0652809335",
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