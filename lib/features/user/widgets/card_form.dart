import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/stripe/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class CardForm extends ConsumerStatefulWidget {
  const CardForm({
    Key? key,
    this.payButtonText = "Payer avec cette carte",
    this.isFormCommerce = false,
  }) : super(key: key);

  final String payButtonText;

  final bool isFormCommerce;

  @override
  ConsumerState<CardForm> createState() => _CardFormState();
}

class _CardFormState extends ConsumerState<CardForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _cardNumber = "";
  String _cvvCode = "";
  String _expiryDate = "";
  String _holderName = "";

  bool _isCVVFocused = false;

  String _errorMessage = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ScreenHelper.instance.horizontalPadding),
          child: _isLoading ? const Center(child: CircularProgressIndicator(),) : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_errorMessage.isNotEmpty) ...{
                ClStatusMessage(
                  message: _errorMessage,
                ),
                const SizedBox(height: 12.0,) 
              },
    
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth >= ScreenHelper.breakpointTablet) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _content().reversed.toList()
                    );
                  }
    
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _content(),
                  );
                },
              )
            ],
          ),
        )
      ),
    );
  }

  List<Widget> _content() {
    return [
      Flexible(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 300),
          child: CreditCardWidget(
            cardBgColor: Theme.of(context).colorScheme.primary,
            // glassmorphismConfig: Glassmorphism.defaultConfig(),
            cardNumber: _cardNumber,
            expiryDate: _expiryDate, 
            cardHolderName: _holderName,
            cvvCode: _cvvCode, 
            showBackView: _isCVVFocused, 
            isHolderNameVisible: true,
            onCreditCardWidgetChange: (changes) {},
          ),
        ),
      ),
      const SizedBox(height: 12,),

      Flexible(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CreditCardForm(
              formKey: _formKey,
              cardNumber: _cardNumber,
              expiryDate: _expiryDate,
              cvvCode: _cvvCode,
              cardHolderName: _holderName,
              themeColor: Theme.of(context).colorScheme.primary,
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
      
            ElevatedButton(
              onPressed: _handlePayPress,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock),
                  const SizedBox(width: 4,),
      
                  Text(widget.payButtonText),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Retourner aux cartes"),
                ],
              )
            )
          ],
        ),
      )
    ];
  }

  InputDecoration _fieldDecoration({
    required String label,
    required String hint,
  }) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      fillColor:  Theme.of(context).colorScheme.surface,
      filled: true,
      labelText: label,
      hintText: hint,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outline
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.outline
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }

  Future _handlePayPress() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    final String? userToken = ref.read(appUserControllerProvider).token;

    if (userToken == null) {
      setState(() {
        _isLoading = false;
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
        const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData()
        )
      );

      final setupIntentResult = await StripeService.instance.handleSetupIntent(
        authorizationHeader: authHeader,
        isForCommerce: widget.isFormCommerce,
        paymentMethodId: paymentMethod.id,
      );

      final String? clientSecret = setupIntentResult["clientSecret"] as String?;

      if (clientSecret != null) {
        final setupIntent = await Stripe.instance.confirmSetupIntent(clientSecret, const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData()
        ));

        Navigator.of(context).pop(setupIntent.paymentMethodId);
      }
    }
    on Exception catch(e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "Le paiement n'a pas put se faire... $e";
      });
    }
  }
}