import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:flutter/material.dart';

class PageDescriptionCard extends StatelessWidget {
  const PageDescriptionCard({
    Key? key,
    required this.descriptionTextController,
    required this.isEditing,
  }) : super(key: key);

  final TextEditingController descriptionTextController;
  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      // backgroundColor: isEditing ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).cardColor, 
      child: isEditing ?
        // First case, edit mode show a text input
        ClTextInput(
          controller: descriptionTextController,
          labelText: "Description de votre commerce",
          hintText: "Rentrer la description de votre commerce",
          maxLines: 3,
          inputType: TextInputType.multiline,
          validator: (value) {
            if (value.isEmpty) return "Vous devez rentrer une description";

            return null;
          },
        ) :
        // Second case, we just show the actual text
        Text(descriptionTextController.text),
    );
  }
}