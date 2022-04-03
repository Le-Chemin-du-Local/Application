import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/basket/basket.dart';
import 'package:chemin_du_local/features/basket/basket_page/basket_payment_form.dart';
import 'package:chemin_du_local/features/basket/basket_product.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  Basket basket = const Basket(
    products: {
      "6241fc008c8a112094e0ffea": [
        BasketProduct(
          Product("6245c3d295477883aecf93b1", name: "Bière blonde"),
          2
        ),
        BasketProduct(
          Product("6245c3d295477883aecf93b2", name: "Bière ambrée"),
          1
        )
      ]
    }, 
    commerces: [
      Commerce("6241fc008c8a112094e0ffea", name: "La Bizhhh")
    ]
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
        child: Column(
          children: [
            // La liste des produits
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.pink,
                  height: 1000,
                ),    
              ),
            ),

            // Le bouton
            ClElevatedButton(
              onPressed: _onProceedToPayment, 
              child: Row(
                children: const [
                  Icon(Icons.shopping_basket_sharp),
                  SizedBox(width: 12,),

                  Text("Valider mon panier")
                ],
              )
            ),
            const SizedBox(height: 12,)
          ],
        ),
      ),
    );  
  }

  Future _onProceedToPayment() async {
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => const BasketPaymentForm() 
      )
    );  
  }
}