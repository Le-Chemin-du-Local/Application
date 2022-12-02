import 'dart:async';

import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment/cancel_page/widgets/summary_card.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:flutter/material.dart';

class CancelPage extends StatefulWidget {
  const CancelPage({
    Key? key, 
    required this.basket
  }) : super(key: key);

  final Basket basket;

  @override
  State<CancelPage> createState() => _CancelPageState();
}

class _CancelPageState extends State<CancelPage> {
  late Timer _timer;
  int _remainingTime = 5;

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1), 
      (Timer timer) {
        if (_remainingTime == 0) {
          setState(() {
            _timer.cancel();
          });

          Navigator.of(context).pop(false);
        }
        else {
          setState(() {
            _remainingTime--;
          });
        }
      }
    );
  }

  @override
  void initState() {
    super.initState();

    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenHelper.instance.horizontalPadding,
          vertical: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20,),
            _buildLoadingIndicator(),
            const SizedBox(height: 20,),

            Expanded(
              child: SingleChildScrollView(
                child: SummaryCard(basket: widget.basket),
              ),
            ),
            const SizedBox(height: 8,),

            ElevatedButton(
              onPressed: () {
                _timer.cancel();
                Navigator.of(context).pop(true);
              }, 
              child: const Text("Annuler ma commande")
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      height: 62, width: 62,
      child: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: 1),
                duration: const Duration(seconds: 5),
                builder: (context, value, _) => SizedBox(
                  height: 62, width: 62,
                  child: CircularProgressIndicator(
                    color: const Color(0xff63d266),
                    value: value,
                    strokeWidth: 12,
                  ),
                ),
              ),
            ),
          ),

          Positioned.fill(
            child: Center(
              child: Text(
                _remainingTime.toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          )
        ],
      ),
    );
  }
}