import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/authentication_graphql.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_step_1.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_step_2.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_step_3.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_step_password.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_step_welcome.dart';
import 'package:chemin_du_local/features/place/place_service.dart';
import 'package:chemin_du_local/features/place/widgets/address_controller.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:latlng/latlng.dart';

mixin RegistrationType {
  static const String client = "client";
  static const String storekeeper = "storekeeper";
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    Key? key,
    required this.onRegistred,
    required this.onStepChanged,
    required this.onTypeChanged,
  }) : super(key: key);

  final Function() onRegistred;

  final Function(int) onStepChanged;
  final Function(String) onTypeChanged;

  @override
  State<RegistrationForm> createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  bool _success = false;

  final PageController _pageController = PageController();
  final GlobalKey<FormState> _step1FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _step2FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _step3FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  String _registrationType = "";

  // Controllers étape 1
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _storeNameTextController = TextEditingController();
  final TextEditingController _storeSiretTextController = TextEditingController();

  // Controllers étape 2
  final AddressController _addressController = AddressController();
  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();

  DateTime? _birthdate;
  String _gender = "";

  // Controllers étape de commerce
  final AddressController _storeAddressController = AddressController();
  final TextEditingController _storePhoneTextController = TextEditingController();
  
  String _storeType = "";
  
  // Controllers étape mot de passe
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _passwordConfirmTextController = TextEditingController();

  bool _hasAcceptedConditions = false;

  MutationOptions _registerUserMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(mutRegisterUser),
      onCompleted: (dynamic data) {
        if (data == null) return;
        
        final int offset = _registrationType == RegistrationType.storekeeper ? 1 : 0;
        widget.onStepChanged(3 + offset);
        _success = true;
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Mutation<dynamic>(
      options: _registerUserMutationOptions(),
      builder: (runRegisterMutation, registerMutationResult) {
        if (registerMutationResult?.isLoading ?? false) {
          return const Center(child: CircularProgressIndicator(),);
        }

        if (_success) {
          return RegistrationStepWelcome(onStartNavigation: widget.onRegistred);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (registerMutationResult?.hasException ?? false) 
              const Align(
                alignment: Alignment.topCenter,
                child: ClStatusMessage(
                  message: "Nous n'avons pas réussi à vous inscrire...",
                )
              ),

            Flexible(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  // Les infos de base
                  RegistrationStep1(
                    formKey: _step1FormKey,
                    emailTextController: _emailTextController,
                    phoneTextController: _phoneTextController,
                    storeNameTextController: _storeNameTextController,
                    storeSiretTextController: _storeSiretTextController,
                    onCompleted: _goOnStep2
                  ),
                  
                  // Les infos complémentaires
                  RegistrationStep2(
                    formKey: _step2FormKey,
                    firstNameTextController: _firstNameTextController, 
                    lastNameTextController: _lastNameTextController,
                    addressController: _addressController,
                    gender: _gender,
                    onGenderChanged: (newGender) {
                      setState(() {
                        _gender = newGender ?? "";
                      });
                    },
                    initialDate: _birthdate,
                    onBirthdateChange: (newDate) {
                      setState(() {
                        _birthdate = DateTime.tryParse(newDate ?? "");
                      });
                    },
                    onNext: () => _goOnStep3(),
                  ),
            
                  // Les infos du commerce
                  if (_registrationType == RegistrationType.storekeeper)
                    RegistrationStep3(
                      formKey: _step3FormKey,
                      addressController: _storeAddressController,
                      storeKeeperAddress: _addressController.address,
                      phoneTextController: _storePhoneTextController,
                      storeType: _storeType,
                      onStoreTypeChanged: (value) {
                        setState(() {
                          _storeType = value ?? "";
                        });
                      },
                      onNext: _goOnPassword,
                    ),
                  
                  // Le mot de passe et consentement
                  RegistrationStepPassword(
                    formKey: _passwordFormKey,
                    hasAcceptedConditions: _hasAcceptedConditions,
                    passwordTextController: _passwordTextEditingController,
                    passwordConfirmTextController: _passwordConfirmTextController,
                    onConditionAcceptationChanged: (value) {
                      setState(() {
                        _hasAcceptedConditions = value ?? false;
                      });
                    },
                    onNext: () => _register(
                      registerRunMutation: runRegisterMutation
                    ),
                  ),

            
                ],
              ),
            ),
          ],
        );
      }
    );
  }

  void goOnStep(int index) {
    if (_success) return;

    _animateScroll(index);
  }

  Future _animateScroll(int page) async {
    await _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future _goOnStep2(String type) async {
    if (!(_step1FormKey.currentState?.validate() ?? false)) return;

    setState(() {
      _registrationType = type;
    });

    _animateScroll(1);
    widget.onStepChanged(1);
    widget.onTypeChanged(type);
  }
  
  Future _goOnStep3() async {
    if(!(_step2FormKey.currentState?.validate() ?? false)) return;
    
    _animateScroll(2);
    widget.onStepChanged(2);
  }

  Future _goOnPassword() async {
    if(!(_step3FormKey.currentState?.validate() ?? false)) return;

    _animateScroll(3);
    widget.onStepChanged(3);
  }

  Future _register({
    required RunMutation? registerRunMutation
  }) async {
    if (!(_passwordFormKey.currentState?.validate() ?? false)) return;
    if (!_hasAcceptedConditions) return;

    LatLng? storeAddressCoordinates;
    if (_registrationType == RegistrationType.storekeeper) {
      storeAddressCoordinates = await PlaceAPIProvider.instance.latLgnForAddress(_storeAddressController.address.detailled);
      if (storeAddressCoordinates == null) {
        // TODO: show error message
        return;
      }
    }

    if (registerRunMutation != null) {
      registerRunMutation(<String, dynamic>{
        "newUser": <String, dynamic>{
          "email": _emailTextController.text,
          "phone": _phoneTextController.text,
          "password": _passwordTextEditingController.text,
          "gender": _gender,
          "firstName": _firstNameTextController.text,
          "lastName": _lastNameTextController.text,
          "birthdate": _birthdate!.toUtc().toIso8601String(),
          "address": _addressController.address,
          if (_registrationType == RegistrationType.storekeeper) 
            "commerce": <String, dynamic>{
              "name": _storeNameTextController.text,
              "siret": _storeSiretTextController.text,
              "address": _storeAddressController.address,
              "latitude": storeAddressCoordinates!.latitude,
              "longitude": storeAddressCoordinates.longitude,
              "phone": _storePhoneTextController.text,
              "email": _emailTextController.text,
            }
        }
      });
    }
  }
}