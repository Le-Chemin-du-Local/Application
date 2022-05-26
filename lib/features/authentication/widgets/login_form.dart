import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.onLogin,
    required this.onRegister,
  }) : super(key: key);

  final Function(Map<String, dynamic>) onLogin;
  final Function() onRegister;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The Email field
            ClTextInput(
              controller: _emailTextController,
              labelText: "Mon adresse mail",
              hintText: "jean@mail.com",
              inputType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty) return "Vous devez rentrer un email";
                return null;
              },
            ),
            const SizedBox(height: 12,),
        
            // The Password field
            ClTextInput(
              controller: _passwordTextController,
              labelText: "Mon mot de passe",
              hintText: "**********",
              obscureText: true,
              validator: (value) {
                if (value.isEmpty) return "Vous devez rentrer un mot de passe";
                return null;
              },
            ),
            const SizedBox(height: 40,),
        
            ElevatedButton(
              onPressed: _onConnect,
              child: const Text("Me connecter"),
            ),
            const SizedBox(height: 12,),
      
            ElevatedButton(
              onPressed: widget.onRegister, 
              child: const Text("Créer mon compte")
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  void _onConnect() {
    if (!_formKey.currentState!.validate()) return;

    final loginInfo = <String, dynamic>{
      "email": _emailTextController.text,
      "password": _passwordTextController.text
    };

    widget.onLogin(loginInfo);
  }
}