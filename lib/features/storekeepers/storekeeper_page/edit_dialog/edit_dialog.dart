import 'dart:convert';

import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/dialog/closable_dialog.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_image_picker.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_image_picker_big.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/edit_dialog/widgets/schedule_field_controller.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/edit_dialog/widgets/schedule_form.dart';
import 'package:chemin_du_local/features/place/models/address/address.dart';
import 'package:chemin_du_local/features/place/place_service.dart';
import 'package:chemin_du_local/features/storekeepers/storekeepers_graphql.dart';
import 'package:chemin_du_local/features/place/widgets/address_controller.dart';
import 'package:chemin_du_local/features/place/widgets/address_form.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:latlng/latlng.dart';

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
  String _errorMessage = "";

  ClFile? _image;
  ClFile? _profilePicture;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _storekeeperWordController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final AddressController _addressController = AddressController();

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

  // Pour les horaires de Click&Collect
  final ScheduleFieldController _ccMondayController = ScheduleFieldController();
  final ScheduleFieldController _ccTuesdayController = ScheduleFieldController();
  final ScheduleFieldController _ccWednesdayController = ScheduleFieldController();
  final ScheduleFieldController _ccThursdayController = ScheduleFieldController();
  final ScheduleFieldController _ccFridayController = ScheduleFieldController();
  final ScheduleFieldController _ccSaturdayController = ScheduleFieldController();
  final ScheduleFieldController _ccSundayController = ScheduleFieldController();

  MutationOptions _updateCommerceOptions() {
    return MutationOptions<dynamic>(
      document: gql(mutUpdateStorekeerCommerce),
      onError: (error) {
        _errorMessage = "Nous n'avons pas pu mettre à jour votre commerce. Veuillez vérifier votre connexion internet et recommencer.";
      },
      onCompleted: (dynamic data) {
        if (data != null) {
          Navigator.of(context).pop(true);
        }
      }
    );
  }

  void _initialize() {
    if (widget.commerce != null) {
      _storekeeperWordController.text = widget.commerce!.storekeeperWord ?? "";
      _descriptionController.text = widget.commerce!.description ?? "";

      _addressController.address = widget.commerce?.address ?? const Address();

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

      _ccMondayController.schedules = widget.commerce?.clickAndCollectHours?.monday ?? [];
      _ccTuesdayController.schedules = widget.commerce?.clickAndCollectHours?.tuesday?? [];
      _ccWednesdayController.schedules = widget.commerce?.clickAndCollectHours?.wednesday ?? [];
      _ccThursdayController.schedules = widget.commerce?.clickAndCollectHours?.thursday ?? [];
      _ccFridayController.schedules = widget.commerce?.clickAndCollectHours?.friday ?? [];
      _ccSaturdayController.schedules = widget.commerce?.clickAndCollectHours?.saturday ?? [];
      _ccSundayController.schedules = widget.commerce?.clickAndCollectHours?.sunday ?? [];
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
    return Mutation<dynamic>(
      options: _updateCommerceOptions(),
      builder: (runMutation, mutationResult) {
        return ClosableDialog(
          title: "Ma fiche commerce",
          child: Builder(
            builder: (context) {
              if (mutationResult?.isLoading ?? false) {
                return const Center(child: CircularProgressIndicator(),);
              }

              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_errorMessage.isNotEmpty) ...{
                        ClStatusMessage(message: _errorMessage,),
                        const SizedBox(height: 22,),
                      },

                      // La photo de profil
                      Text(
                        "Logo du commerce",
                        style: ScreenHelper.instance.isMobile 
                          ? Theme.of(context).textTheme.titleMedium
                          : Theme.of(context).textTheme.headlineSmall
                      ),
                      const SizedBox(height: 8,),
                      Center(
                        child: ClImagePicker(
                          imageURL: "$kImagesBaseUrl/commerces/${widget.commerce?.id ?? ""}/profile.jpg", 
                          imageData: _profilePicture,
                          onImageSelected: _onProfilePictureSelected,
                          size: 120,
                        ),
                      ),
                      const SizedBox(height: 22,),

                      // La photo de couverture
                      Text(
                        "Photo de couverture du commerce", 
                        style: ScreenHelper.instance.isMobile 
                          ? Theme.of(context).textTheme.titleMedium
                          : Theme.of(context).textTheme.headlineSmall
                      ),
                      const SizedBox(height: 8,),
                      Center(
                        child: ClImagePickerBig(
                          imageURL: "$kImagesBaseUrl/commerces/${widget.commerce?.id ?? ""}/header.jpg", 
                          imageData: _image,
                          onImageSelected: _onCoverSelected,
                        ),
                      ),
                      const SizedBox(height: 22,),

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
                      Text(
                        "Horaires d'ouverture du commerce", 
                        style: ScreenHelper.instance.isMobile 
                          ? Theme.of(context).textTheme.titleMedium
                          : Theme.of(context).textTheme.headlineSmall
                      ),
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

                      // Les horaires de click and collect
                      Text(
                        "Gestion des créneaux de Click&Collect", 
                        style: ScreenHelper.instance.isMobile 
                          ? Theme.of(context).textTheme.titleMedium
                          : Theme.of(context).textTheme.headlineSmall
                      ),
                      ScheduleForm(
                        mondayController: _ccMondayController,
                        tuesdayController: _ccTuesdayController,
                        wednesdayController: _ccWednesdayController,
                        thursdayController: _ccThursdayController,
                        fridayController: _ccFridayController,
                        saturdayController: _ccSaturdayController,
                        sundayController: _ccSundayController,
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
                        child: AddressForm(
                          addressController: _addressController,
                        ),
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
              );
            },
          ),
          actions: [
            const SizedBox(height: 10,),
            // Le bouton de validation
            ElevatedButton(
              onPressed: () => _validateForm(runMutation),
              child: const Text("Sauvegarder"),
            )
          ],
        );
      }
    );
  }

  void _onProfilePictureSelected(ClFile image) {
    setState(() {
      _profilePicture = image;
    });
  }

  void _onCoverSelected(ClFile image) {
    setState(() {
      _image = image;
    });
  }

  Future _validateForm(RunMutation? runMutation) async {
    if (!_formKey.currentState!.validate() || runMutation == null) return;

    LatLng? commerceLatLgn = await PlaceAPIProvider.instance.latLgnForAddress(_addressController.address.detailled);

    if (commerceLatLgn == null) {
      setState(() {
        _errorMessage = "Nous n'arrivons pas à récupérer les coordonnées du commerce. Verifiez l'adresse.";
      });
    }

    runMutation(<String, dynamic>{
      "id": widget.commerce?.id,
      "changes": <String, dynamic>{
        "storekeeperWord": _storekeeperWordController.text,
        "description": _descriptionController.text,
        "address": _addressController.address.toJson(),
        "latitude": commerceLatLgn!.latitude,
        "longitude": commerceLatLgn.longitude,
        "phone": _phoneController.text,
        "email": _emailController.text,
        "facebook": _facebookController.text,
        "twitter": _twitterController.text,
        "instagram": _instagramController.text,
        "businessHours": {
          "monday": _mondayController.schedules,
          "tuesday": _tuesdayController.schedules,
          "wednesday": _wednesdayController.schedules,
          "thursday": _thursdayController.schedules,
          "friday": _fridayController.schedules,
          "saturday": _saturdayController.schedules,
          "sunday": _sundayController.schedules,
        },
        "clickAndCollectHours": {
          "monday": _ccMondayController.schedules,
          "tuesday": _ccTuesdayController.schedules,
          "wednesday": _ccWednesdayController.schedules,
          "thursday": _ccThursdayController.schedules,
          "friday": _ccFridayController.schedules,
          "saturday": _ccSaturdayController.schedules,
          "sunday": _ccSundayController.schedules,
        },
        if (_profilePicture != null) 
          "profilePicture": MultipartFile.fromBytes(
            "profilePicture",
            base64Decode(_profilePicture!.base64content!),
            filename: _profilePicture!.filename
          ),
        if (_image != null) 
          "image": MultipartFile.fromBytes(
            "image",
            base64Decode(_image!.base64content!),
            filename: _image!.filename
          ),
      }
    });
  }
}