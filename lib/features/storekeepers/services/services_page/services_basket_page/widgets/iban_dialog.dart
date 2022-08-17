import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:flutter/material.dart';
import 'package:iban/iban.dart';

class IbanDialog extends StatefulWidget {
  const IbanDialog({Key? key}) : super(key: key);

  @override
  State<IbanDialog> createState() => _IbanDialogState();
}

class _IbanDialogState extends State<IbanDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _ibanOwnerTextController = TextEditingController();
  final TextEditingController _ibanTextController = TextEditingController();
  final TextEditingController _bicTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: EdgeInsets.all(ScreenHelper.instance.horizontalPadding),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Le titre et la description
                Text("Entrez votre IBAN", style: Theme.of(context).textTheme.headlineLarge,),
                const SizedBox(height: 12,),
                const Text("Pour que vous poussiez recevoir l'argent des commandes de vos clients, nous avons besoin de votre IBAN pour pouvoir vous faire des virements bancaires"),
                const SizedBox(height: 20,),
          
                // Les différents champs
                ClTextInput(
                  controller: _ibanOwnerTextController, 
                  labelText: "Prénom/Nom du titulaire du compte",
                  hintText: "Eskild LEGOURIEREC",
                  validator: (value) {
                    if (value.isEmpty) return "Vous devez rentrer une valeur";
                    return null;
                  }, 
                ),
                const SizedBox(height: 12,),
          
                ClTextInput(
                  controller: _ibanTextController,
                  labelText: "IBAN",
                  hintText: "FRXXXXXXXXXXXXXXXXXXXXXXXXX",
                  validator: (value) {
                    if (value.isEmpty) return "Vous devez rentrer une valeur";
          
                    if (!isValid(value)) return "L'IBAN est invalide";
          
                    return null;
                  },
                ),
                const SizedBox(height: 12,),
          
                ClTextInput(
                  controller: _bicTextController,
                  labelText: "BIC",
                  hintText: "Par exemple : SOGEFRPP",
                  validator: (value) {
                    if (value.isEmpty) return "Vous devez rentrer uen valeur";
                    return null;
                  },
                ),
                const SizedBox(height: 20,),
          
                // Le bouton de validation
                ElevatedButton.icon(
                  onPressed: _onValidate, 
                  icon: const Icon(Icons.check), 
                  label: const Text("Confirmer la souscription")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onValidate() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(<String, dynamic>{
      "ibanOwner": _ibanOwnerTextController.text,
      "iban": _ibanTextController.text,
      "bic": _bicTextController.text
    });
  }
}