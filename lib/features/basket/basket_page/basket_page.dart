import 'package:chemin_du_local/core/helpers/app_manager.dart';
import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/steps_indicator.dart';
import 'package:chemin_du_local/features/authentication/app_user_controller.dart';
import 'package:chemin_du_local/features/authentication/login_dialog.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_commerce_schedule/basket_commerce_schedules.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment/basket_payment.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_success/basket_success.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_summary/basket_summary.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/basket/riverpod/basket_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BasketPage extends ConsumerStatefulWidget {
  const BasketPage({
    Key? key,
    required this.onShowDrawer,
  }) : super(key: key);

  final Function() onShowDrawer;

  @override
  ConsumerState<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends ConsumerState<BasketPage> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentIndex = 0;
  int _currentStep = 0;
  Basket? _successBasket;

  @override
  Widget build(BuildContext context) {
    return ref.watch(basketControllerProvider).basket.when(
      data: (data) => _buildContent(data),
      loading: () => const Center(child: CircularProgressIndicator(),),
      error: (error, stackTrace) => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenHelper.instance.horizontalPadding),
          child: const ClStatusMessage(
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
            if (_currentIndex == 0) {
              _currentStep = 0;
            }
            else if (_currentIndex <= basket.commerces.length + 1) {
              _currentStep = 1;
            }
            else if (_currentIndex == basket.commerces.length + 2) {
              _currentStep = 2;
            }
            else {
              _currentStep = 3;
            }
            _animateScroll(_currentIndex);
          });

          return false;
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: ScreenHelper.instance.isMobile 
          ?  _currentIndex == 0 ? null : const BackButton()
          :  _currentIndex != 0 ? const BackButton() : Padding(
              padding: EdgeInsets.only(
                left: ScreenHelper.instance.horizontalPadding,
              ),
              child: IconButton(
                onPressed: () {
                  widget.onShowDrawer();
                },
                icon: const Icon(Icons.menu)
              ),
            ),
          leadingWidth: 32 + ScreenHelper.instance.horizontalPadding,
          title: const Text("Mion Panier"),
        ),
        body: _successBasket != null ? BasketSuccess(basket: _successBasket!) : Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 54 - ScreenHelper.instance.horizontalPadding,
              ),
              child: StepsIndicator(
                currentStep: _currentStep, 
                stepsTitle: const [
                  "Panier", "Créneaux", "Coordonnées", "Confirmation",
                ], 
                onStepClicked: _selectStep
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              flex: 1,
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  BasketSummary(
                    basket: basket,
                    onPay: _onProceedToPayment,
                  ),
                  for (final commerce in basket.commerces) 
                    BasketCommerceSchedules(
                      commerceID: commerce.commerceID,
                      onDateChoosed: (date) => _onScheduleChoosed(basket, commerce.commerceID, date),
                    ),
                  BasketPayment(
                    basket: basket,
                    onHasBeenPayed: () {
                      setState(() {
                        _successBasket = basket;
                        });
                        ref.watch(basketControllerProvider.notifier).reset();
                      },
                  )
                ],
              ),
            ),
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
        _currentStep = 1;
        _animateScroll(_currentIndex);
      });
    }
    else {
      await showDialog<dynamic>(
        context: context, 
        // barrierDismissible: true,
        builder: (context) => const LoginDialog(
          title: "Veuillez vous connecter pour passer commande",
          returnToBasket: true,
        )
      );
    }
  }

  void _onScheduleChoosed(Basket basket, String commerceID, DateTime time) async {
    ref.read(basketControllerProvider.notifier).updateSchedule(commerceID, time);
    setState(() {
        if (_currentIndex == basket.commerces.length) _currentStep = 2;
        _currentIndex++;
        _animateScroll(_currentIndex);
      });
  }

  void _selectStep(int step) {
    setState(() {
      _currentStep = step;
      if (step == 0) {
        _currentIndex = 0;
      }
      else if (step == 1) {
        _currentIndex = 1;
      }
      else if (step == 2) {
        // _currentIndex == 
      }

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