import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/authentication_graphql.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_step_1.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_step_2.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_step_3.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_step_password.dart';
import 'package:chemin_du_local/features/commerces/commerces_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

mixin RegistrationType {
  static const String client = "client";
  static const String storekeeper = "storekeeper";
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    Key? key,
    required this.onRegistred,
  }) : super(key: key);

  final Function() onRegistred;

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _step1FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _step2FormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  String _registrationType = "";

  // Controllers étape 1
  final TextEditingController _firstNameTextController = TextEditingController();
  final TextEditingController _lastNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();

  DateTime? _birthdate;

  // Controllers étape 2
  final TextEditingController _storeNameTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();
  
  String _storeType = "";
  
  // Controllers étape mot de passe
  final TextEditingController _passwordTextEditingController = TextEditingController();
  final TextEditingController _passwordConfirmTextController = TextEditingController();

  bool _hasAcceptedConditions = false;

  RunMutation? _createCommerceRunMutation;

  MutationOptions _registerUserMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(mutRegisterUser),
      onCompleted: (dynamic data) {
        if (data == null) return;
        if (_registrationType == RegistrationType.client) {
          widget.onRegistred();
          return;
        }

        final String? userID = data["createUser"]["id"] as String?;

        if (userID == null || _createCommerceRunMutation == null) {
          return;
        }

        _createCommerceRunMutation!(<String, dynamic>{
          "userID": userID,
          "name": _storeNameTextController.text,
          "address": _addressTextController.text,
          "latitude": 0,
          "longitude": 0,
          "phone": _phoneTextController.text,
          "email": _emailTextController.text,
        });
      }
    );
  }

  MutationOptions _createCommerceMutationOptions() {
    return MutationOptions<dynamic>(
      document: gql(mutCreateCommerce),
      onCompleted: (dynamic data) {
        if (data != null) widget.onRegistred();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Mutation<dynamic>(
      options: _createCommerceMutationOptions(),
      builder: (runCreateCommerceMutation, createCommerceMutationResult) {
        _createCommerceRunMutation = runCreateCommerceMutation;

        return Mutation<dynamic>(
          options: _registerUserMutationOptions(),
          builder: (runRegisterMutation, registerMutationResult) {
            if ((registerMutationResult?.isLoading ?? false) || 
                (createCommerceMutationResult?.isLoading ?? false)) {
              return const Center(child: CircularProgressIndicator(),);
            }

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if ((registerMutationResult?.hasException ?? false) ||
                    (createCommerceMutationResult?.hasException ?? false)) ...{
                  const Align(
                    alignment: Alignment.topCenter,
                    child: ClStatusMessage(
                      message: "Nous n'avons pas réussi à vous inscrire...",
                    )
                  )
                },

                Flexible(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: [
                      // Le choix commerçant/client
                      RegistrationStep1(
                        onTypeChoosed: (type) {
                          setState(() {
                            _registrationType = type;
                          });
                          _animateScroll(1);
                        }
                      ),
                      
                      // Les infos basiques
                      RegistrationStep2(
                        formKey: _step1FormKey,
                        firstNameTextController: _firstNameTextController, 
                        lastNameTextController: _lastNameTextController,
                        emailTextController: _emailTextController,
                        phoneTextController: _phoneTextController,
                        initialDate: _birthdate,
                        onBirthdateChange: (newDate) {
                          setState(() {
                            _birthdate = DateTime.tryParse(newDate ?? "");
                          });
                        },
                        onNext: _goOnStep2,
                      ),
                
                      // Les infos du commerce
                      if (_registrationType == RegistrationType.storekeeper)
                        RegistrationStep3(
                          formKey: _step2FormKey,
                          storeNameController: _storeNameTextController,
                          addressTextController: _addressTextController,
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
                      )
                
                    ],
                  ),
                ),
              ],
            );
          }
        );
      }
    );
  }

  Future _animateScroll(int page) async {
    await _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future _goOnStep2() async {
    if (!(_step1FormKey.currentState?.validate() ?? false)) return;

    _animateScroll(2);
  }

  Future _goOnPassword() async {
    if(!(_step2FormKey.currentState?.validate() ?? false)) return;

    _animateScroll(3);
  }

  void _register({
    required RunMutation? registerRunMutation
  }) {
    if (!(_passwordFormKey.currentState?.validate() ?? false)) return;
    if (!_hasAcceptedConditions) return;

    if (registerRunMutation != null) {
      registerRunMutation(<String, dynamic>{
        "email": _emailTextController.text,
        "password": _passwordTextEditingController.text,
        "firstName": _firstNameTextController.text,
        "lastName": _lastNameTextController.text,
      });
    }
  }
}