import 'package:chemin_du_local/core/helpers/app_manager.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/authentication/login_dialog.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment_form.dart';
import 'package:chemin_du_local/features/basket/basket_page/widgets/basket_summary.dart';
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

  // Future _initialize() async {
  //   bool goToPayment = ref.read(appUserControllerProvider).goBackToBasketPayment;

  //   if (goToPayment) {
  //     await Future<void>.delayed(const Duration(milliseconds: 100));
  //     AppManager.instance.basketPageIndex = 1;
  //     _pageController.jumpToPage(1);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
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
        appBar: AppBar(),
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BasketSummary(
              onPay: _onProceedToPayment,
            ),
            const BasketPaymentForm()
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

  Future _animateScroll(int page) async {
    AppManager.instance.basketPageIndex = page;
    await _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }
}