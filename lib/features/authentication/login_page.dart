import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/authentication/authentication_graphql.dart';
import 'package:chemin_du_local/features/authentication/widgets/login_form.dart';
import 'package:chemin_du_local/features/authentication/widgets/registration_form.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isRegistering = false;

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

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("Mon Compte"),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: Palette.gradientPrimary
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // The content
                Positioned(
                  top: 230,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  // width: constraints.maxWidth,
                  child: Center(
                    child: Container(
                      width: constraints.maxWidth > maxFormWidth ? maxFormWidth : constraints.maxWidth,
                      height: double.infinity,
                      padding: const EdgeInsets.all(ScreenHelper.horizontalPadding),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Theme.of(context).scaffoldBackgroundColor
                      ),
                      child: SingleChildScrollView(
                        controller: ScrollController(),
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
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(maxHeight: constraints.maxHeight - 230),
                                      child: const RegistrationForm()
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
                ),

                // The Logo
                Positioned(
                  top: 123.2,
                  width: constraints.maxWidth,
                  child: Center(
                    child: Image.asset(
                      "assets/images/hermine.png",
                      height: 130,
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }

  void _onConnect(Map<String, dynamic> loginInfo, RunMutation loginRunMutation) {
    loginRunMutation(loginInfo);
  }
}