import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/steps_indicator.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/authentication/authentication_graphql.dart';
import 'package:chemin_du_local/features/authentication/widgets/login_form.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    Key? key,
    required this.onShowDrawer,
  }) : super(key: key);

  final Function onShowDrawer;

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<RegistrationFormState> _registrationFormKey = GlobalKey<RegistrationFormState>();
  bool _isRegistering = false;
  String _registrationType = RegistrationType.client;
  int _currentStep = 0;

  MutationOptions<dynamic> _loginMutationOptions(WidgetRef ref) {
    return MutationOptions<dynamic>(
      document: gql(mutAuthentication),
      onCompleted: (dynamic data) {
        if (data == null) return;

        final String token = data['login'] as String? ?? "";
        
        if (token.isNotEmpty) {
          // Then we can actually login the user
          ref.read(appUserControllerProvider.notifier).loginUser(
            token,
            goBackToBasketPayment: false
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    const double maxFormWidth = 500;

    return WillPopScope(
      onWillPop: () async {
        if (_currentStep != 0) {
          _currentStep--;
          _registrationFormKey.currentState!.goOnStep(_currentStep);
          return false;
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: ScreenHelper.instance.isMobile 
          ? _currentStep == 0 ? null : const BackButton() 
          : _currentStep != 0 ? const BackButton() : Padding(
              padding: EdgeInsets.only(
                left: ScreenHelper.instance.horizontalPadding,
              ),
              child: IconButton(
                onPressed: () {
                  widget.onShowDrawer();
                },
                icon: const Icon(Icons.menu)
              ),
            ),
          leadingWidth: 32 + ScreenHelper.instance.horizontalPadding,
          title: Text(
            _isRegistering ? "Inscription" : "Connexion/Inscription"
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  // The content
                  Positioned(
                    top: 157,
                    left: 0,
                    right: 0,
                    bottom: -10,
                    // width: constraints.maxWidth,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ClCard(
                        width: constraints.maxWidth > maxFormWidth ? maxFormWidth : constraints.maxWidth,
                        padding: EdgeInsets.only(
                          top: 20,
                          left: ScreenHelper.instance.horizontalPadding,
                          right: ScreenHelper.instance.horizontalPadding,
                        ),
                        child: Mutation<dynamic>(
                          options: _loginMutationOptions(ref),
                          builder: (loginRunMutation, loginMutationResult) {
                            if (loginMutationResult?.isLoading ?? false) {
                              return const Center(child: CircularProgressIndicator(),);
                            }
    
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (loginMutationResult?.hasException ?? false) ...{
                                  const Align(
                                    alignment: Alignment.topCenter,
                                    child: ClStatusMessage(
                                      message: "Nous n'arrivons pas à vous connecter... Vérifier votre email et votre mot de passe",
                                    )
                                  ),
                                  const SizedBox(height: 20,)
                                },
    
                                if (_isRegistering) 
                                  Flexible( 
                                    child: RegistrationForm(
                                      key: _registrationFormKey,
                                      onRegistred: () {
                                        setState(() {
                                          _isRegistering = false;
                                          _currentStep = 0;
                                        });
                                      },
                                      onStepChanged: (step) {
                                        setState(() {
                                          _currentStep = step;
                                        });
                                      },
                                      onTypeChanged: (type) {
                                        setState(() {
                                          _registrationType = type;
                                        });
                                      },
                                    )
                                  )
                                else 
                                  Flexible(
                                    child: LoginForm(
                                      onLogin: (info) => _onConnect(info, loginRunMutation),
                                      onRegister: () {
                                        setState(() {
                                          _isRegistering= true;
                                        });
                                      },
                                                                  ),
                                  ),
                              ],
                            );
                          }
                        ),
                      ),
                    ),
                  ),
    
                  // The Logo
                  Positioned(
                    top: 50.2,
                    width: constraints.maxWidth,
                    child: Center(
                      child: Image.asset(
                        "assets/images/hermine.png",
                        height: 130,
                      ),
                    ),
                  ),
    
                  // L'indication des étapes
                  if (_isRegistering)
                    Positioned(
                      top: 8,
                      left: 50,
                      right: 50,
                      child: Center(
                        child: StepsIndicator(
                          currentStep: _currentStep,
                          onStepClicked: (step) {
                            setState(() {
                              _currentStep = step;
                            });
                            if (_registrationFormKey.currentState != null) {
                              _registrationFormKey.currentState!.goOnStep(step);
                            }
                          },
                          stepsTitle: [
                            if (_registrationType == RegistrationType.storekeeper) 
                              "",
                            "", 
                            "", 
                            "", 
                            ""
                          ],
                        ),
                      ),
                    )
                ],
              );
            }
          ),
        ),
      ),
    );
  }

  void _onConnect(Map<String, dynamic> loginInfo, RunMutation loginRunMutation) {
    loginRunMutation(loginInfo);
  }
}