import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:flutter/material.dart';

class ServiceInfoCard extends StatelessWidget {
  const ServiceInfoCard({
    Key? key,
    required this.serviceInfo,
    required this.serviceType,
    required this.onTypeChanged,
    this.isMonthlyTransitioning = false,
    this.buttonText = "En savoir plus",
    this.onButtonClick,
    this.isSelected = false,
    this.forceHideBorder = false,
    this.onSelect
  }) : super(key: key);

  final ServiceInfo serviceInfo;

  final String buttonText;
  final Function()? onButtonClick;

  final bool isSelected;
  final bool forceHideBorder;
  final Function(bool)? onSelect;

  final ServiceType? serviceType;
  final Function(ServiceType) onTypeChanged;
  final bool isMonthlyTransitioning;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect == null ? null : () => onSelect!(!isSelected),
      child: Opacity(
        opacity: !isSelected && onSelect != null ? 0.4 : 1,
        child: ClCard(
          padding: const EdgeInsets.all(12),
          borderColor: (isSelected || onSelect != null) && !forceHideBorder 
            ? Theme.of(context).colorScheme.primary 
            : Theme.of(context).colorScheme.surface,
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleMedium!,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // L'image et le bouton
                      AspectRatio(
                        aspectRatio: 0.64,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // L'image
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  "$kImagesBaseUrl/services/${serviceInfo.id}.png",
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                    ),
                                  ),
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.image, size: 92, color: Theme.of(context).colorScheme.outline,);
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 4,),
                          
                            if (onButtonClick != null) 
                              ElevatedButton(
                                onPressed: onButtonClick,
                                child: Text(buttonText),
                              )
                          ],
                        ),
                      ),
                      const SizedBox(width: 10,),
                          
                      // Le reste
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Le titre
                            Text(serviceInfo.name, style: Theme.of(context).textTheme.headlineMedium,),
                            const SizedBox(height: 4,),
                          
                            // La description
                            Text(serviceInfo.shortDescription),
                            const SizedBox(height: 4,),
                          
                            // Le prix
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                                text: serviceType == ServiceType.monthly 
                                  ? "${serviceInfo.monthPrice}€*"
                                  : "${serviceInfo.transactionPercentage}%",
                                children: [
                                  TextSpan(
                                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                                    text: serviceType == ServiceType.monthly 
                                      ? " /mois"
                                      : " /transactions"
                                  )
                                ]
                              ),
                            ),
                          
                            // Le switch
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: _buildSwitch(context),
                              ),
                            ),
                          ],
                        ),
                      )
                      
                    ],
                  ),
                ),

                // Le text d'info au besoin
                if (isMonthlyTransitioning)
                  const Text(
                    "Ce changement prendra effet lors de la prochaine facture",
                    style: TextStyle(fontSize: 12),
                  )
                else 
                  const SizedBox(height: 12,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitch(BuildContext context) {
    return Row(
      children: [
        const Flexible(child: Text("Mensuelle")),
        Switch(
          value: serviceType == ServiceType.transactions, 
          onChanged: (value) {
            if (!isSelected && onSelect != null) return;

            if (value) {
              onTypeChanged(ServiceType.transactions);
            }
            else {
              onTypeChanged(ServiceType.monthly);
            }
          },
          activeColor: Theme.of(context).colorScheme.secondary,
          inactiveThumbColor: Theme.of(context).colorScheme.secondary,
          activeTrackColor: Theme.of(context).colorScheme.secondary.withAlpha(150),
          inactiveTrackColor: Theme.of(context).colorScheme.secondary.withAlpha(150),
        ),
        const Flexible(child: Text("Consommation"))
      ],
    );
  }
}