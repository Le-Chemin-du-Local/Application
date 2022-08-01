import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment/basket_payment_graphql.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment/cancel_page/cancel_page.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment/cards_list/cards_list.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment/widgets/payment_method_card.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment/widgets/summary_card.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_price.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/stripe/stripe_service.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class BasketPayment extends ConsumerStatefulWidget {
  const BasketPayment({
    Key? key,
    required this.basket,
    required this.onHasBeenPayed,
  }) : super(key: key);

  final Basket basket;

  final Function() onHasBeenPayed;

  @override
  ConsumerState<BasketPayment> createState() => _BasketPaymentState();
}

class _BasketPaymentState extends ConsumerState<BasketPayment> {
  String _selectedCard = "";

  bool _isLoading = false;
  String _errorMessage = "";

  QueryOptions _userPaymentInfoOptions() {
    return QueryOptions<dynamic>(
      document: gql(qUserPaymentInfo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(
        horizontal: ScreenHelper.instance.horizontalPadding,
        vertical: 16
      ),
      child: Query<dynamic>(
        options: _userPaymentInfoOptions(),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading || _isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (result.hasException) {
            return const Align(
              alignment: Alignment.topCenter,
              child: ClStatusMessage(
                message: "Nous n'arrivons pas à récupérer vos informations de paiement",
              ),
            );
          }

          final User appUser = User.fromJson(result.data?["user"] as Map<String, dynamic>? ?? <String, dynamic>{});
          return ClipRect(
            child: Navigator(
              onGenerateRoute: (route) => MaterialPageRoute<void>(
                settings: route,
                builder: (context) => _buildContent(
                  context,
                  refetch: refetch,
                  user: appUser
                )
              ),
            )
          );
        },
      )
    );
  }

  Widget _buildContent(BuildContext context, {
    required User user,
    Refetch? refetch
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Les infos de facturation
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_errorMessage.isNotEmpty) ...{
                  ClStatusMessage(message: _errorMessage,),
                  const SizedBox(height: 18,)
                },

                // Le récapitulatif
                SummaryCard(basket: widget.basket),
                const SizedBox(height: 18,),

                // La méthode de paimement
                InkWell(
                  onTap: () => _onListPaymentMethods(context, refetch, user),
                  child: PaymentMethodCard(
                    appUser: user,
                    paymentMethodId: _selectedCard,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 12,),

        ElevatedButton.icon(
          onPressed: _selectedCard.isEmpty ? null : _onPay, 
          icon: const Icon(Icons.lock),
          label: Text("Payer ${BasketPrice.calculatePrice(widget.basket).toStringAsFixed(2)}€")
        )
      ],
    );
  }

  Future _onListPaymentMethods(BuildContext context, Refetch? refetch, User user) async {
    final String? newPaymentMethod = await Navigator.of(context).push<String?>(
      MaterialPageRoute(
        builder: (context) => CardsList(
          initialSelectedCard: _selectedCard,
          user: user,
          refetch: refetch,
        ),
      )
    );

    if (newPaymentMethod != null) {
      setState(() {
        _selectedCard = newPaymentMethod;
      });
    }
  }

  Future _onPay() async {
    bool shouldCancel = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => CancelPage(basket: widget.basket)
      )
    ) ?? false;

    if (shouldCancel) return;

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

      await StripeService.instance.handleCreateOrder(
        authorizationHeader: authHeader, 
        paymentMethodId: _selectedCard,
        basket: widget.basket
      );

      setState(() {
        _isLoading = false;
        _errorMessage = "";
      });
      widget.onHasBeenPayed();
    } 
    on Exception {
      setState(() {
        _isLoading = false;
        _errorMessage = "Nous n'avons pas réussi à passer la commande";
      });
    }
  }
}