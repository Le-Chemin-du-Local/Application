import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/commands/commerce_command_details_page/widgets/commerce_command_summary_card.dart';
import 'package:chemin_du_local/features/commands/commerce_command_details_page/widgets/commerce_info_card.dart';
import 'package:chemin_du_local/features/commands/commerce_command_details_page/widgets/validation_button.dart';
import 'package:chemin_du_local/features/commands/models/commerce_command/commerce_command.dart';
import 'package:chemin_du_local/features/stripe/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CommerceCommandDetailsPage extends ConsumerStatefulWidget {
  const CommerceCommandDetailsPage({
    Key? key,
    required this.commerceCommand,
  }) : super(key: key);

  final CommerceCommand commerceCommand;

  @override
  ConsumerState<CommerceCommandDetailsPage> createState() => _CommerceCommandDetailsPageState();
}

class _CommerceCommandDetailsPageState extends ConsumerState<CommerceCommandDetailsPage> {
  bool _isLoading = false;
  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: Navigator.of(context).canPop(),
        title: Text(widget.commerceCommand.commerce?.name ?? "Nom inconnue")
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: ScreenHelper.instance.horizontalPadding
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Message d'erreur si nécessaire
                    if (_errorMessage.isNotEmpty) ...{
                      ClStatusMessage(
                        message: _errorMessage,
                      ),
                      const SizedBox(height: 12),
                    },
          
                    // Text descriptif
                    Text(
                      "Présentez-vous au commerce au créneau de collecte indiqué en lui présentant la carte associée à l’adresse. Il validera ce reçu et vous pourrez repartir avec les produits de votre commerçant préféré 😉",
                      style: Theme.of(context).textTheme.titleMedium,  
                    ),
                    const SizedBox(height: 24,),
          
                    // Le recapitluatif
                    CommerceCommandSummaryCard(command: widget.commerceCommand),
                    const SizedBox(height: 12,),
          
                    // Les infos sur le commerce
                    if (widget.commerceCommand.commerce != null) ...{
                      CommerceInfoCard(commerce: widget.commerceCommand.commerce!),
                      const SizedBox(height: 64,),
                    },
                  ],
                ),
              ),
            ),
          ),
          // Le bouton de validation
          Positioned(
            bottom: 28,
            left: ScreenHelper.instance.horizontalPadding,
            right: ScreenHelper.instance.horizontalPadding,
            child: ValidationButton(
              onValidate: widget.commerceCommand.status == CommandStatus.ready 
                ? _onValidate
                : null
            ),
          )
        ],
      ),
    );
  }

  Future _onValidate() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = "";
      });

      final String? userToken = ref.read(appUserControllerProvider).token;

      if (userToken == null) {
        setState(() {
          _isLoading = false;
          _errorMessage = "Vous n'auriez jamais du vous retrouver ici... Vous devez vous connecter avant de finaliser votre achat.";
        });
      }

      final String authHeader = "Bearer $userToken";


      final paymentIntentResult = await StripeService.instance.handleCompleteOrder(
        authorizationHeader: authHeader,
        orderId: widget.commerceCommand.id!
      );

      final String? clientSecret = paymentIntentResult["clientSecret"] as String?;
      final bool? requiresAction = paymentIntentResult["requiresAction"] as bool?;

      if (clientSecret != null && !(requiresAction ?? false)) {
        Navigator.of(context).pop(true);
      }

      if (clientSecret != null && (requiresAction ?? false)) {
         final paymentIntent = await Stripe.instance.handleNextAction(clientSecret);

         final result = await StripeService.instance.handleCompleteOrder(
           authorizationHeader: authHeader,
           orderId: widget.commerceCommand.id!,
           paymentIntentId: paymentIntent.id,
          );

         if ((result["clientSecret"] as String?) != null) {
           Navigator.of(context).pop();
         }
      }
    } on Exception {
      setState(() {
        _isLoading = false;
        _errorMessage = "Nous ne parvenons pas à valider votre commande...";
      });
    }
  }
}