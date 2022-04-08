import 'package:chemin_du_local/features/authentication/widgets/registration_step_1.dart';
import 'package:flutter/material.dart';

mixin RegistrationType {
  static const String client = "client";
  static const String storekeeper = "storekeeper";
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final PageController _pageController = PageController();

  String _registrationType = "";

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
        // Text("Hello Column")
        RegistrationStep1(onTypeChoosed: (type) {
          setState(() {
            _registrationType = type;
          });
        })
      ],
    );
  }

  Future _animateScroll(int page) async {
    await _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}