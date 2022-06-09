import 'package:flutter/material.dart';

class StepsIndicator extends StatelessWidget {
  const StepsIndicator({
    Key? key,
    required this.currentStep,
    required this.stepsTitle,
    required this.onStepClicked
  }) : super(key: key);

  final int currentStep;
  final List<String> stepsTitle;

  final Function(int) onStepClicked;


  @override
  Widget build(BuildContext context) {
    // On doit quand même prévoir le cas d'un stepper vide
    if (stepsTitle.isEmpty) {
      return const Center(child: Text("Il n'y a pas d'étape..."),);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Les premiers widgets
        for (int i = 0; i < stepsTitle.length - 1; ++i) ...{
          // Le rond 
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (i == 0) 
                        Flexible(child: Container(height: 2,))
                      else 
                        Flexible(
                          child: Container(
                            height: 2,
                            color: i >= currentStep + 1 ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      InkWell(
                        onTap: currentStep < i ? null : () => onStepClicked(i),
                        child: _buildIndicator(context, i)
                      ),
                      Flexible(
                        child: Container(
                          height: 2,
                          color: i >= currentStep ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(stepsTitle[i]),
              ],
            ),
          ),
          // La ligne
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 2,
                  color: i >= currentStep ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: 19,)
              ],
            )
          )
        },
        // Le dernier rond
        IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Container(
                      height: 2,
                      color: currentStep != stepsTitle.length - 1 ? Theme.of(context).colorScheme.secondaryContainer : Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  InkWell(
                    onTap: currentStep < stepsTitle.length - 1 ? null : () => onStepClicked(stepsTitle.length - 1),
                    child: _buildIndicator(context, stepsTitle.length - 1)
                  ),
                  Flexible(child: Container(height: 2,))
                ],
              ),
              Text(stepsTitle.last)
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIndicator(BuildContext context, int index) {
    // L'indicateur d'étape active
    if (index == currentStep) {
      return Container(
        height: 24, width: 24,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Container(
            height: 20, width: 20,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Container(
                height: 16, width: 16,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                )
              ),
            ), 
          ),
        ),
      );
    }

    // L'indicateur d'étape à venir
    if (index > currentStep) {
      return Container(
        height: 24, width: 24,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
      );
    }

    // L'indicateur d'étape passée
    return Container(
      height: 24, width: 24,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  } 
}