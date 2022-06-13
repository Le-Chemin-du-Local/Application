import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment/cards_list/widgets/card_card.dart';
import 'package:chemin_du_local/features/user/models/user/user.dart';
import 'package:chemin_du_local/features/user/widgets/card_form.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CardsList extends StatefulWidget {
  const CardsList({
    Key? key, 
    required this.user,
    required this.initialSelectedCard,
    this.refetch,
  }) : super(key: key);

  final String initialSelectedCard;
  final User user;

  final Refetch? refetch;

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  String _selectedCard = "";

  void _initialize() {
    _selectedCard = widget.initialSelectedCard;
  }

  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant CardsList oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // TODO: Liste des cartes
        if (widget.user.registeredPaymentMethods.isEmpty) 
          const ClStatusMessage(
            type: ClStatusMessageType.info,
            message: "Vous n'avez pas de carte disponible pour le moment",
          )
        else 
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final paymentMethod in widget.user.registeredPaymentMethods) ...{
                  CardCard(
                    paymentMethod: paymentMethod, 
                    choosedPaymentMethod: _selectedCard, 
                    onSelected: (value) {
                      setState(() {
                        _selectedCard = value ?? ""; 
                      });
                    }
                  ),
                  const SizedBox(height: 16),
                }
              ],
            ),
          ),
        const SizedBox(height: 18,),
        OutlinedButton(
          onPressed: _onAddCard,
          child: const Text("Ajouter une nouvelle carte"),
        ),
        ElevatedButton(
          onPressed: _onPayWithCard, 
          child: const Text("Payer avec cette carte")
        )
      ],
    );
  }

  Future _onAddCard() async {
    final String? paymentMethodId = await Navigator.of(context).push<String?>(
      MaterialPageRoute(
        builder: (context) => const CardForm()
      )
    );

    if (paymentMethodId != null) {
      if (widget.refetch != null) widget.refetch!();
      Navigator.of(context).pop(paymentMethodId);
    }
  }

  Future _onPayWithCard() async {
    if (_selectedCard.isNotEmpty) {
      Navigator.of(context).pop(_selectedCard);
    } 
  }
}