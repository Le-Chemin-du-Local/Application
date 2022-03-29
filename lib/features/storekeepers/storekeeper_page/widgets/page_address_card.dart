import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/core/widgets/gradient_icon.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/place_service.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_address_input.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_address_map.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:uuid/uuid.dart';

class PageAddressCard extends StatelessWidget {
  const PageAddressCard({
    Key? key,
    required this.phoneTextController,
    required this.emailTextController,
    required this.addressTextController,
    required this.facebookTextController,
    required this.twitterTextController,
    required this.instagramTextController,
    required this.isEditing,
  }) : super(key: key);

  final TextEditingController phoneTextController;
  final TextEditingController emailTextController;
  final TextEditingController addressTextController;

  final TextEditingController facebookTextController;
  final TextEditingController twitterTextController;
  final TextEditingController instagramTextController;

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
          Flexible(
            child: PageAddressMap(
              address: addressTextController.text,
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
        Flexible(
          child: PageAddressInput(addressTextController: addressTextController),
        ),
        const SizedBox(height: 8.0,),  

        // Facebook
        ClTextInput(
          controller: facebookTextController,
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
        const SizedBox(height: 8.0,),

        // Twitter
        ClTextInput(
          controller: twitterTextController,
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
        const SizedBox(height: 8.0,),

        // Instagram
        ClTextInput(
          controller: instagramTextController,
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
        const SizedBox(height: 8.0,),
      ],
    );
  }

  Widget _buildCoordinateText(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Flexible(
          child: Row(
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
          ),
        ),
        const SizedBox(height: 20,),

        Flexible(child: _buildSocialNetworksIcons(),),
      ],
    );
  }

  Widget _buildSocialNetworksIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo Facebook
        if (facebookTextController.text.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GradientIcon(
              FontAwesome.facebook_f,
              size: 32,
              gradient: Palette.gradientPrimary,
            ),
          ),

        // Logo Twitter
        if (twitterTextController.text.isNotEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GradientIcon(
              FontAwesome.twitter,
              size: 32,
              gradient: Palette.gradientPrimary
            ),
          ),

        // Logo Instagram
        if (instagramTextController.text.isNotEmpty) 
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: GradientIcon(
              FontAwesome.instagram,
              size: 32,
              gradient: Palette.gradientPrimary
            ),
          )
      ],
    );
  }
}