import 'package:chemin_du_local/core/helpers/app_manager.dart';
import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/authentication/login_dialog.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment_form.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_commerce_schedules.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_success.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_summary.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/basket/riverpod/basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketPage extends ConsumerStatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  ConsumerState<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends ConsumerState<BasketPage> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentIndex = 0;
  Basket? _successBasket;

  @override
  Widget build(BuildContext context) {
    return ref.watch(basketControllerProvider).basket.when(
      data: (data) => _buildContent(data),
      loading: () => const Center(child: CircularProgressIndicator(),),
      error: (error, stackTrace) => const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
          child: ClStatusMessage(
            message: "Nous n'arrivons pas à charger votre panier...",
          ),
        ),
      )
    );
  }

  Widget _buildContent(Basket basket) {
    return WillPopScope(
      onWillPop: () async {
        if (_successBasket != null) {
          setState(() {
            _successBasket = null;
            _currentIndex = 0;
          });

          return false;
        }
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex--; 
            _animateScroll(_currentIndex);
          });

          return false;
        }

        return true;
      },
      child: Scaffold(
        body: _successBasket != null ? BasketSuccess(basket: _successBasket!) : PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BasketSummary(
              basket: basket,
              onPay: _onProceedToPayment,
            ),
            for (final commerce in basket.commerces) 
              BasketCommerceSchedule(
                commerce: commerce.commerce,
                onDateChoosed: (date) => _onScheduleChoosed(commerce.commerce.id!, date),
              ),
            BasketPaymentForm(
              basket: basket,
              onSuccess: () {
                setState(() {
                  _successBasket = basket;
                });
                ref.watch(basketControllerProvider.notifier).reset();
              },
            )
          ],
        ),
      ), 
    );
  }

  Future _onProceedToPayment() async {
    final bool isConnected = ref.read(appUserControllerProvider).token != null;

    if (isConnected) {
      setState(() {
        _currentIndex = 1;
        _animateScroll(_currentIndex);
      });
    }
    else {
      await showDialog<dynamic>(
        context: context, 
        barrierDismissible: true,
        builder: (context) => const LoginDialog(
          title: "Veuillez vous connecter pour passer commande",
          returnToBasket: true,
        )
      );
    }
  }

  void _onScheduleChoosed(String commerceID, DateTime time) async {
    ref.read(basketControllerProvider.notifier).updateSchedule(commerceID, time);
    setState(() {
        _currentIndex++;
        _animateScroll(_currentIndex);
      });
  }

  Future _animateScroll(int page) async {
    AppManager.instance.basketPageIndex = page;
    await _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}