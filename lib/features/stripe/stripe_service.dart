import 'dart:convert';
import 'dart:io';

import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<Map<String, dynamic>> handlePaymentIntent({
    required String authorizationHeader,
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
        "items": <String>[]
      })
    );

    if (response.statusCode != 200) {
      throw PlatformException(code: response.statusCode.toString(), message: response.body);
    }

    return json.decode(response.body) as Map<String, dynamic>;
  }
}