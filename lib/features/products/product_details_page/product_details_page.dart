import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_quantity_picker.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:chemin_du_local/features/basket/models/basket_commerce/basket_commerce.dart';
import 'package:chemin_du_local/features/basket/models/basket_product/basket_product.dart';
import 'package:chemin_du_local/features/basket/riverpod/basket_controller.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/products/models/product/product.dart';
import 'package:chemin_du_local/features/products/products_graphql.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProductDetailsPage extends ConsumerWidget {
  const ProductDetailsPage({
    Key? key,
    required this.commerce,
    required this.productID
  }) : super(key: key);

  final Commerce commerce;
  final String productID;

  QueryOptions<dynamic> _detailledProductQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qDetailledProduct),
      variables: <String, dynamic>{
        "productID": productID
      }
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenHelper.instance.horizontalPadding,
        vertical: 12
      ),
      child: Query<dynamic>(
        options: _detailledProductQueryOptions(),
        builder: (result, {fetchMore, refetch}) {
          if (result.isLoading) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          if (result.hasException) {
            return Scaffold(
              appBar: AppBar(),
              body: const Align(
                alignment: Alignment.topCenter,
                child: ClStatusMessage(
                  message: "Le produit n'a pas pu être chargé...",
                ),
              ),
            );
          }

          final Product product = Product.fromJson(result.data!["product"] as Map<String, dynamic>);

          return _buildContent(context, ref, product); 
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, Product product) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // La première partie
                  Flexible(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final bool isBig = constraints.maxWidth >= ScreenHelper.breakpointTablet;
                        final List<Widget> children = [
                          // L'image du produit
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: isBig ? 300 : double.infinity),
                                child: AspectRatio(
                                  aspectRatio: isBig ? 0.65 : 1.65,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.network(
                                      "$kImagesBaseUrl/products/${product.id ?? ""}.jpg",
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) => loadingProgress == null ? child : Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                            : null,
                                        ),
                                      ),
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.image, size: 92, color: Theme.of(context).colorScheme.outline,);
                                      },
                                    )
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12,),
                          
                              // Si il est breton, on l'indique
                              if (product.isBreton ?? false)
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/images/drapeau_breton.png", width: 25,),
                                      const SizedBox(width: 5,),
                                                    
                                      Flexible(
                                        child: Text("Produit 100% de chez vous", style: Theme.of(context).textTheme.titleMedium,),
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                          const SizedBox(width: 20, height: 20,),
              
                          // La description et allergène
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // La description
                                Text(
                                  "Decription", 
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).colorScheme.secondary    
                                  ),
                                ),
                                const SizedBox(height: 2,),
                                Text(
                                  product.description ?? "Pas de description",
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w300
                                  )
                                ),
                                const SizedBox(height: 10,),
          
                                // La description
                                Text(
                                  "Allergène", 
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).colorScheme.secondary    
                                  ),
                                ),
                                const SizedBox(height: 2,),
                                Text(
                                  _productAllergens(product),
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w300
                                  )
                                )
                          
                              ],
                            ),
                          )
                        ];
              
                        if (isBig) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: children,
                          );
                        }
              
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: children,
                        );
                      }
                    ),
                  )
                ],
              ),
            ),
          ),

          // Le bouton d'ajout au panier
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: ClCard(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "${product.price}€",
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: const [
                          TextSpan(text: "/pièce", style: TextStyle(fontSize: 12.0))
                        ]
                      ),
                    ),
                    const SizedBox(width: 10,),

                    Flexible(
                      child: ref.watch(basketControllerProvider).basket.when(
                        data: (data) => _buildBasketButton(context, ref, data, product),
                        loading: () => const Center(child: CircularProgressIndicator(),),
                        error: (error, stackTrace) => const Align(
                          alignment: Alignment.topCenter,
                          child: ClStatusMessage(
                            message: "Quelque chose c'est mal passé...",
                          ),
                        )
                      )
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasketButton(BuildContext context, WidgetRef ref, Basket basket, Product product) {
    final BasketCommerce? basketCommerce = _commerceForID(basket, commerce.id ?? "");
    final int quantity = _basketProduct(basketCommerce)?.quantity ?? 0;

    if (quantity > 0) {
      return ClQuantityPicker(
        minValue: 0,
        currentValue: quantity,
        onChanged: (value) => _updateProductOnBasket(ref, product, value),
      );
    }
    return  ElevatedButton(
      child: const Text("Ajouter au panier"),
      onPressed: () => _updateProductOnBasket(ref, product, 1)
    );
  }

  String _productAllergens(Product product) {
    if (product.allergens.isEmpty) return "Pas d'allergènes";

    String result = "";

    for (final allergen in product.allergens) {
      result += ", $allergen";
    }

    return result.replaceFirst(", ", "");
  }


  Future _updateProductOnBasket(WidgetRef ref, Product updated, int quantity) async {
    final BasketCommerce basketCommerce = _commerceForID(ref.read(basketControllerProvider).basket.value, commerce.id!) ?? BasketCommerce(
      commerce: commerce,
      products: const []
    );

    final List<BasketProduct> basketProducts = basketCommerce.products;

    // Premier cas, on ajoute le produit
    if (quantity >= 1) {
      await ref.read(basketControllerProvider.notifier).updateBasketCommerce(
        basketCommerce.copyWith(
          products: [
            for (final product in basketProducts)
              if (product.product.id == updated.id) 
                BasketProduct(quantity: quantity, product: updated)
              else 
                product
          ]
        )
      );
    }
    
    if (quantity == 1 && _commerceForID(ref.read(basketControllerProvider).basket.value, commerce.id!) == null) {
      await ref.read(basketControllerProvider.notifier).addBasketCommerce(
        BasketCommerce(
          commerce: commerce,
          products: [
            BasketProduct(product: updated, quantity: quantity)
          ]
        )
      );
    }
    else if (quantity == 1 && (_basketProduct(basketCommerce) == null)) { // Second cas, on ajoute le produit 
      await ref.read(basketControllerProvider.notifier).updateBasketCommerce(
        basketCommerce.copyWith(
          products: [
            ...basketProducts,
            BasketProduct(product: updated, quantity: quantity)
          ]
        )
      );
    }
    else if (quantity == 0) {
      await ref.read(basketControllerProvider.notifier).updateBasketCommerce(
        basketCommerce.copyWith(
          products: [
            for (final product in basketProducts)
              if (product.product.id != updated.id) 
                product
          ]
        )
      );
    }

  }

  BasketCommerce? _commerceForID(Basket? basket, String id) {
    if (basket == null) return null;

    for (final commerce in basket.commerces) {
      if (commerce.commerce.id == id) return commerce;
    }

    return null;
  }

  BasketProduct? _basketProduct(BasketCommerce? commerce) {
    if (commerce == null) return null;

    for (final basketProduct in commerce.products) {
      if (basketProduct.product.id == productID) return basketProduct;
    }

    return null;
  }
}