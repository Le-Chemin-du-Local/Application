import 'dart:convert';
import 'dart:io';

import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/features/basket/basket.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<Map<String, dynamic>> handlePaymentIntent({
    required String authorizationHeader,
    required Basket basket,
    String? paymentMethodId,
    String? paymentIntentId,
  }) async {
    final response = await http.post(
      Uri.parse("$kRESTApiBaseUrl/create-payment-intent"),
      headers: {
        HttpHeaders.authorizationHeader: authorizationHeader,
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: json.encode({
        "useStripeSDK": true,
        if (paymentMethodId != null)
          "paymentMethodId": paymentMethodId, 
        if (paymentIntentId != null) 
          "paymentIntentId": paymentIntentId,
        "basket": <String, dynamic>{
          "commerces": <Map<String, dynamic>>[
            for (final commerce in basket.commerces) <String, dynamic>{
              "commerceID": commerce.commerce.id,
              "pickupDate": commerce.pickupDate?.toUtc().toIso8601String(),
              "products": <Map<String, dynamic>>[
                for (final product in commerce.products) <String, dynamic>{
                  "quantity": product.quantity,
                  "productID": product.product.id
                }
              ],
              "paniers": <String?>[
                for (final panier in commerce.paniers)
                  panier.id
              ]
            }
          ]
        }
      })
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }

    return json.decode(response.body) as Map<String, dynamic>;
  }
}