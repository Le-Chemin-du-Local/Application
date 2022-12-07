import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_text_input.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:flutter/material.dart';

class SimulationCard extends StatefulWidget {
  const SimulationCard({
    Key? key, 
    required this.serviceInfo,
  }) : super(key: key);

  final ServiceInfo serviceInfo;

  @override
  State<SimulationCard> createState() => _SimulationCardState();
}

class _SimulationCardState extends State<SimulationCard> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _caTextController = TextEditingController();

  double _result = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClCard(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Le titre
                Text(
                  "Simulez le tarif évolutif - Votre CA prévu pour le premier mois sur Le Chemin du Local ?",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500
                  ),
                ),
                const SizedBox(height: 8,),
          
                // Le champs de CA
                ClTextInput(
                  controller: _caTextController,
                  labelText: "",
                  hintText: "1500",
                  inputType: const TextInputType.numberWithOptions(decimal: true),
                  suffixIcon: Icons.euro,
                  validator: (value) {
                    if (value.isEmpty) return "Vous devez rentrer un CA";
                    if (double.tryParse(value.replaceAll(",", ".")) == null) return "Vous devez rentrer un nombre valide";
                    return null;
                  },
                ),
                const SizedBox(height: 8,),
          
                // Le bouton
                ElevatedButton(
                  onPressed: _simulate, 
                  child: const Text("Simuler mon tarif")
                ),
                const SizedBox(height: 8,),

                // Le champs d'affichage de la simulation
                ClTextInput(
                  controller: TextEditingController(text: _result.toStringAsFixed(2)), 
                  labelText:"",
                  validator: null, 
                  readOnly: true,
                  invisibleReadOnly: true,
                  suffixIcon: Icons.euro,
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 12,),

        Text(
          "Une question ? Contactez-nous !",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w500
          ),
        )
      ],
    );
  }

  void _simulate() {
    if (!_formKey.currentState!.validate()) return;

    double currentCA = double.parse(_caTextController.text.replaceAll(",", "."));
    int augmentationFactor = 0;
    double nextCALimit = widget.serviceInfo.monthMinimumAllowedCA;

    double result = widget.serviceInfo.monthPrice;

    while(nextCALimit < currentCA) {
      augmentationFactor++;
      nextCALimit *= 1 + (widget.serviceInfo.monthRangePercentage / 100);
    }

    for (int i = 0; i < augmentationFactor; ++i) {
      result *= 1 + (widget.serviceInfo.monthAugmentationPerRangePercentage / 100);
    }

    setState(() {
      _result = result;
    });
  }
}