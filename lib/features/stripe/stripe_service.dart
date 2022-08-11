import 'dart:convert';
import 'dart:io';

import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/features/basket/models/basket/basket.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<Map<String, dynamic>> handleCreateOrder({
    required String authorizationHeader,
    required Basket basket,
    String? paymentMethodId,
  }) async {
    final response = await http.post(
      Uri.parse("$kRESTApiBaseUrl/create-order"),
      headers: {
        HttpHeaders.authorizationHeader: authorizationHeader,
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: json.encode({
        if (paymentMethodId != null)
          "paymentMethodId": paymentMethodId, 
        "basket": <String, dynamic>{
          "commerces": <Map<String, dynamic>>[
            for (final commerce in basket.commerces) <String, dynamic>{
              "commerceID": commerce.commerceID,
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


  Future<Map<String, dynamic>> handleCompleteOrder({
    required String authorizationHeader,
    required String orderId,
    String? paymentIntentId,
  }) async {
    final response = await http.post(
      Uri.parse("$kRESTApiBaseUrl/complete-order"),
      headers: {
        HttpHeaders.authorizationHeader: authorizationHeader,
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: json.encode({
        "commerceCommandId": orderId,
        if (paymentIntentId != null)
          "paymentIntentId": paymentIntentId, 
      })
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }

    return json.decode(response.body) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> handleSetupIntent({
    required String authorizationHeader,
    bool isForCommerce = false,
    String? paymentMethodId,
    String? setupIntentId,
  }) async {
    final response = await http.post(
      Uri.parse("$kRESTApiBaseUrl/create-setup-intent"),
      headers: {
        HttpHeaders.authorizationHeader: authorizationHeader,
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: json.encode({
        "isForCommerce": isForCommerce,
        if (paymentMethodId != null)
          "paymentMethodId": paymentMethodId, 
      })
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }

    return json.decode(response.body) as Map<String, dynamic>;
  }
}