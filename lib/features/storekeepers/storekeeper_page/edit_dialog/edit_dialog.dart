import 'package:chemin_du_local/core/widgets/dialog/closable_dialog.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_address_input.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/edit_dialog/widgets/schedule_field_controller.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/edit_dialog/widgets/schedule_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class EditDialog extends StatefulWidget {
  const EditDialog({
    Key? key,
    required this.commerce
  }) : super(key: key);

  final Commerce? commerce;

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _storekeeperWordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _twitterController = TextEditingController();
  
  // Pour les horaires
  final ScheduleFieldController _mondayController = ScheduleFieldController();
  final ScheduleFieldController _tuesdayController = ScheduleFieldController();
  final ScheduleFieldController _wednesdayController = ScheduleFieldController();
  final ScheduleFieldController _thursdayController = ScheduleFieldController();
  final ScheduleFieldController _fridayController = ScheduleFieldController();
  final ScheduleFieldController _saturdayController = ScheduleFieldController();
  final ScheduleFieldController _sundayController = ScheduleFieldController();

  void _initialize() {
    if (widget.commerce != null) {
      _storekeeperWordController.text = widget.commerce!.storekeeperWord ?? "";
      _descriptionController.text = widget.commerce!.description ?? "";

      _addressController.text = widget.commerce!.address ?? "";

      _phoneController.text = widget.commerce!.phone ?? "";
      _emailController.text = widget.commerce!.email ?? "";
      _facebookController.text = widget.commerce!.facebook ?? "";
      _instagramController.text = widget.commerce!.instagram ?? "";
      _twitterController.text = widget.commerce!.twitter ?? "";

      _mondayController.schedules = widget.commerce?.businessHours?.monday ?? [];
      _tuesdayController.schedules = widget.commerce?.businessHours?.tuesday?? [];
      _wednesdayController.schedules = widget.commerce?.businessHours?.wednesday ?? [];
      _thursdayController.schedules = widget.commerce?.businessHours?.thursday ?? [];
      _fridayController.schedules = widget.commerce?.businessHours?.friday ?? [];
      _saturdayController.schedules = widget.commerce?.businessHours?.saturday ?? [];
      _sundayController.schedules = widget.commerce?.businessHours?.sunday ?? [];
    }
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant EditDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ClosableDialog(
      title: "Ma fiche commerce",
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Le petit mot du commerçant
              ClTextInput(
                controller: _storekeeperWordController,
                labelText: "Petit mot du commerçant",
                hintText: "Ecrivez un petit mot concernant votre commerce",
                validator: (value) {
                  if (value.isEmpty) return "Vous devez rentrer un mot";
                  return null;
                },
              ),
              const SizedBox(height: 22,),

              // La description du commerce
              ClTextInput(
                controller: _descriptionController,
                labelText: "Description du commerce",
                hintText: "Entrez une description de votre commerce",
                inputType: TextInputType.multiline,
                maxLines: 5,
                validator: (value) {
                  if (value.isEmpty) return "Vous devez rentrer une description";
                  return null;
                },
              ),
              const SizedBox(height: 22,),

              // Les horaires d'ouverture
              Text("Horaires d'ouverture du commerce", style: Theme.of(context).textTheme.caption,),
              ScheduleForm(
                mondayController: _mondayController,
                tuesdayController: _tuesdayController,
                wednesdayController: _wednesdayController,
                thursdayController: _thursdayController,
                fridayController: _fridayController,
                saturdayController: _saturdayController,
                sundayController: _sundayController,
              ),
              const SizedBox(height: 22),

              // Le numéro de téléphone
              ClTextInput(
                controller: _phoneController,
                labelText: "Numéro de téléphone",
                hintText: "Rentrer un numéro de téléphone",
                inputType: TextInputType.phone,
                validator: (value) {
                  if (value.isEmpty) return "Vous devez rentrer un numéro de téléphone";

                  return null;
                },
              ),
              const SizedBox(height: 22.0,),

              // L'email
              ClTextInput(
                controller: _emailController,
                labelText: "Email",
                hintText: "Rentrer un email",
                inputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) return "Vous devez rentrer une adresse mail";

                  return null;
                },
              ),
              const SizedBox(height: 22.0,),

              // L'adresse
              Flexible(
                child: ClAddressInput(addressTextController: _addressController),
              ),
              const SizedBox(height: 22.0,),  

              // Facebook
              ClTextInput(
                controller: _facebookController,
                labelText: "Facebook",
                hintText: "https://facebook.com/monprofile",
                validator: (value) {
                  if (value.isNotEmpty) {
                    if (!value.startsWith("https://facebook.com/")) {
                      return "Vous devez rentrer une adresse commençant par https://facebook.com/";
                    }
                  }

                  return null;
                },
              ),
              const SizedBox(height: 22.0,),

              // Twitter
              ClTextInput(
                controller: _twitterController,
                labelText: "Twitter",
                hintText: "https://twitter.com/monprofile",
                validator: (value) {
                  if (value.isNotEmpty) {
                    if (!value.startsWith("https://twitter.com/")) {
                      return "Vous devez rentrer une adresse commençant par https://twitter.com/";
                    }
                  }

                  return null;
                },
              ),
              const SizedBox(height: 22.0,),

              // Instagram
              ClTextInput(
                controller: _instagramController,
                labelText: "Instagram",
                hintText: "https://instagram.com/monprofile",
                validator: (value) {
                  if (value.isNotEmpty) {
                    if (!value.startsWith("https://instagram.com/")) {
                      return "Vous devez rentrer une adresse commençant par https://instagram.com/";
                    }
                  }

                  return null;
                },
              ),
              const SizedBox(height: 22.0,),
            ],
          ),
        ),
      ),
      actions: [
        const SizedBox(height: 10,),
        // Le bouton de validation
        ElevatedButton(
          onPressed: _validateForm,
          child: const Text("Sauvegarder"),
        )
      ],
    );
  }

  void _validateForm() {
    if (!_formKey.currentState!.validate()) return;
  }
}