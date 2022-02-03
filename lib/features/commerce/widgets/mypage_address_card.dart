import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';

class MyPageAddressCard extends StatelessWidget {
  const MyPageAddressCard({
    Key? key,
    required this.phoneTextController,
    required this.emailTextController,
    required this.addressTextController,
    required this.isEditing
  }) : super(key: key);

  final TextEditingController phoneTextController;
  final TextEditingController emailTextController;
  final TextEditingController addressTextController;

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      // backgroundColor: isEditing ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).cardColor, 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The map
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Palette.colorDarkGrey,
              height: 145,
            ),
          ),
          const SizedBox(height: 12,),

          // The coordinates
          if (isEditing)
            _buildCoordinateForm()
          else 
            _buildCoordinateText(context),
          const SizedBox(height: 12,),

          // The copy button
          Align(
            alignment: Alignment.center,
            child: ClElevatedButton(
              onPressed: () {},
              borderRadius: BorderRadius.circular(6),
              gradient: Palette.colorToGradient(Palette.colorYellow),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.copy, color: Palette.colorDark,),
                  SizedBox(width: 4,),
                  Text("Copier l'adresse", style: TextStyle(color: Palette.colorDark),),
                ],
              )
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCoordinateForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Phone text field
        ClTextInput(
          controller: phoneTextController,
          labelText: "Numéro de téléphone",
          hintText: "Rentrer un numéro de téléphone",
          inputType: TextInputType.phone,
          validator: (value) {
            if (value.isEmpty) return "Vous devez rentrer un numéro de téléphone";

            return null;
          },
        ),
        const SizedBox(height: 8.0,),

        // Email text field
        ClTextInput(
          controller: emailTextController,
          labelText: "Email",
          hintText: "Rentrer un email",
          inputType: TextInputType.emailAddress,
          validator: (value) {
            if (value.isEmpty) return "Vous devez rentrer une adresse mail";

            return null;
          },
        ),
        const SizedBox(height: 8.0,),

        // Address text field
        ClTextInput(
          controller: addressTextController,
          labelText: "Adresse de votre commerce",
          hintText: "Rentrer une adresse",
          validator: (value) {
            if (value.isEmpty) return "Vous devez rentrer une adresse";

            return null;
          },
        )
      ],
    );
  }

  Widget _buildCoordinateText(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The phone and email column
        Expanded(
          child: Container(
            // We have to add a border on this one
            padding: const EdgeInsets.only(right: 24),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 0.5
                )
              )
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Flexible(child: Text("Coordonnées", style: TextStyle(fontWeight: FontWeight.bold),)),
                const SizedBox(height: 4,),
                Flexible(child: Text(phoneTextController.text)),
                const SizedBox(height: 4,),
                Flexible(child: Text(emailTextController.text))
              ],
            ),
          ),
        ),
        const SizedBox(width: 24,),

        // The address column
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(child: Text("Adresse", style: TextStyle(fontWeight: FontWeight.bold),)),
              const SizedBox(height: 4,),
              Flexible(child: Text(addressTextController.text))
            ], 
          )
        )
      ],
    );
  }
}