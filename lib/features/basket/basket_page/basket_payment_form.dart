import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/stripe/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class BasketPaymentForm extends ConsumerStatefulWidget {
  const BasketPaymentForm({Key? key}) : super(key: key);

  @override
  ConsumerState<BasketPaymentForm> createState() => _BasketPaymentFormState();
}

class _BasketPaymentFormState extends ConsumerState<BasketPaymentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _cardNumber = "";
  String _cvvCode = "";
  String _expiryDate = "";
  String _holderName = "";

  bool _isCVVFocused = false;

  String _errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(ScreenHelper.horizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_errorMessage.isNotEmpty) ...{
                ClStatusMessage(
                  message: _errorMessage,
                ),
                const SizedBox(height: 12.0,) 
              },

              CreditCardWidget(
                cardBgColor: Theme.of(context).primaryColor,
                // glassmorphismConfig: Glassmorphism.defaultConfig(),
                cardNumber: _cardNumber,
                expiryDate: _expiryDate, 
                cardHolderName: _holderName,
                cvvCode: _cvvCode, 
                showBackView: _isCVVFocused, 
                isHolderNameVisible: true,
                onCreditCardWidgetChange: (changes) {},
              ),
              const SizedBox(height: 12,),

              CreditCardForm(
                formKey: _formKey,
                cardNumber: _cardNumber,
                expiryDate: _expiryDate,
                cvvCode: _cvvCode,
                cardHolderName: _holderName,
                themeColor: Theme.of(context).primaryColor,
                cardNumberDecoration: _fieldDecoration(label: "Numéro de carte", hint: "XXXX XXXX XXXX XXXX"),
                expiryDateDecoration: _fieldDecoration(label: "Date d'expiration", hint: "XX/XX"),
                cvvCodeDecoration: _fieldDecoration(label: "CVV", hint: "XXX"),
                cardHolderDecoration: _fieldDecoration(label: "Propriétaire", hint: "Victor DENIS"),
                onCreditCardModelChange: (changes) {
                  setState(() {
                    _cardNumber = changes.cardNumber;
                    _cvvCode = changes.cvvCode;
                    _expiryDate = changes.expiryDate;
                    _holderName = changes.cardHolderName;
                    _isCVVFocused = changes.isCvvFocused;
                  });
                },

              ),
              const SizedBox(height: 12,),

              ClElevatedButton(
                onPressed: _handlePayPress,
                child: Text("Payer"),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration({
    required String label,
    required String hint,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      fillColor: Theme.of(context).cardColor,
      filled: true,
      labelText: label,
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(12.0),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  Future _handlePayPress() async {
    if (!_formKey.currentState!.validate()) return;

    final String? userToken = ref.read(appUserControllerProvider).token;

    if (userToken == null) {
      setState(() {
        _errorMessage = "Vous n'auriez jamais du vous retrouver ici... Vous devez vous connecter avant de finaliser votre achat.";
      });
    }

    final String authHeader = "Bearer $userToken";

    // On doit d'abord mettre à jour les infos de cartes
    final CardDetails cardDetails = CardDetails(
      number: _cardNumber,
      cvc: _cvvCode,
      expirationMonth: int.parse(_expiryDate.split("/")[0]),
      expirationYear: int.parse(_expiryDate.split("/")[1]),
    );
    await Stripe.instance.dangerouslyUpdateCardDetails(cardDetails);

    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        const PaymentMethodParams.card()
      );

      final paymentIntentResult = await StripeService.instance.handlePaymentIntent(
        authorizationHeader: authHeader,
        paymentMethodId: paymentMethod.id
      );

      final String? clientSecret = paymentIntentResult["clientSecret"] as String?;
      final bool? requiresAction = paymentIntentResult["requiresAction"] as bool?;

      if (clientSecret != null && !(requiresAction ?? false)) {
        setState(() {
          _errorMessage = "SUCCESS";
        });
      }

      if (clientSecret != null && (requiresAction ?? false)) {
         final paymentIntent = await Stripe.instance.handleCardAction(clientSecret);

         final result = await StripeService.instance.handlePaymentIntent(
           authorizationHeader: authHeader,
           paymentMethodId: paymentMethod.id,
           paymentIntentId: paymentIntent.id
          );

         if ((result["clientSecret"] as String?) != null) {
           setState(() {
             _errorMessage = "SUCCESS";
           });
         }
      }


    }
    on Exception {
      setState(() {
        _errorMessage = "Le paiement n'a pas put se faire...";
      });
    }
  }
}