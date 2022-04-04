import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/dialog/closable_dialog.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/authentication/authentication_graphql.dart';
import 'package:chemin_du_local/features/authentication/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginDialog extends ConsumerWidget {
  const LoginDialog({
    Key? key,
    this.returnToBasket = false,
    this.title = "Connectez vous"
  }) : super(key: key);

  final bool returnToBasket;

  final String title;

  MutationOptions<dynamic> _loginMutationOptions(BuildContext context, WidgetRef ref) {
    return MutationOptions<dynamic>(
      document: gql(mutAuthentication),
      onCompleted: (dynamic data) {
        if (data == null) return;

        final String token = data['login'] as String? ?? "";
        
        if (token.isNotEmpty) {
          // Then we can actually login the user
          ref.read(appUserControllerProvider.notifier).loginUser(
            token,
            goBackToBasketPayment: returnToBasket
          );
          Navigator.of(context).pop();
        }
      }
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: ClosableDialog( 
        title: title,
        child: Mutation<dynamic>(
          options: _loginMutationOptions(context, ref),
          builder: (loginRunMutation, mutationResult) {
            if (mutationResult?.isLoading ?? false) {
              return const Center(child: CircularProgressIndicator(),);
            }
    
            return Column(
              children: [
                if (mutationResult?.hasException ?? false) ...{
                  const ClStatusMessage(message: "Nous n'avons pas réussi à vous connecter",),
                  const SizedBox(height: 12),
                },
    
                LoginForm(
                  onLogin: (info) => _onConnect(info, loginRunMutation),
                  onRegister: () {},
                ),
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