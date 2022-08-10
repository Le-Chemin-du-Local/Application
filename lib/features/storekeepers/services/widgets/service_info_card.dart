import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info.dart';
import 'package:flutter/material.dart';

class ServiceInfoCard extends StatefulWidget {
  const ServiceInfoCard({
    Key? key,
    required this.serviceInfo,
    this.buttonText = "En savoir plus",
    this.onButtonClick,
    this.showBorders = false,
    this.initialServiceType,
  }) : super(key: key);

  final ServiceInfo serviceInfo;

  final String buttonText;
  final Function()? onButtonClick;

  final bool showBorders;

  final ServiceType? initialServiceType;

  @override
  State<ServiceInfoCard> createState() => _ServiceInfoCardState();
}

class _ServiceInfoCardState extends State<ServiceInfoCard> {
  late ServiceType _serviceType;

  void _initialize() {
    _serviceType = widget.initialServiceType ?? ServiceType.monthly;
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant ServiceInfoCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return ClCard(
      padding: const EdgeInsets.all(12),
      borderColor: widget.showBorders ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface,
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.titleMedium!,
        child: Row(
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
                        "$kImagesBaseUrl/services/${widget.serviceInfo.id}.png",
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
      
                  if (widget.onButtonClick != null) 
                    ElevatedButton(
                      onPressed: widget.onButtonClick,
                      child: Text(widget.buttonText),
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
                  Text(widget.serviceInfo.name, style: Theme.of(context).textTheme.headlineMedium,),
                  const SizedBox(height: 4,),
      
                  // La description
                  Text(widget.serviceInfo.shortDescription),
                  const SizedBox(height: 4,),
      
                  // Le prix
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      text: _serviceType == ServiceType.monthly 
                        ? "${widget.serviceInfo.monthPrice}€"
                        : "${widget.serviceInfo.transactionPercentage}%",
                      children: [
                        TextSpan(
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                          text: _serviceType == ServiceType.monthly 
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
                      child: _buildSwitch(),
                    ),
                  )
      
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }

  Widget _buildSwitch() {
    return Row(
      children: [
        const Flexible(child: Text("Mensuelle")),
        Switch(
          value: _serviceType == ServiceType.transactions, 
          onChanged: (value) {
            if (value) {
              setState(() {
                _serviceType = ServiceType.transactions;
              });
            }
            else {
              setState(() {
                _serviceType = ServiceType.monthly;
              });
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