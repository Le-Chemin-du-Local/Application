import 'dart:convert';
import 'dart:io';

import 'package:chemin_du_local/core/utils/constants.dart';
import 'package:chemin_du_local/features/place/models/address/address.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:latlng/latlng.dart';
import 'package:uuid/uuid.dart';

@immutable
class Suggestion {
  final String placeId;
  final String description;

  const Suggestion(this.placeId, this.description);
}

class PlaceAPIProvider {
  PlaceAPIProvider._();

  static final PlaceAPIProvider instance = PlaceAPIProvider._();

  Future<List<Suggestion>> fetchSuggestions(String input, String lang, String sessionToken) async {
    final String sessionTokenString = sessionToken.isNotEmpty ? "&sessiontoken=$sessionToken" : "";

    final response = await http.post(
      Uri.parse("$kRESTApiBaseUrl/maps/autocomplete"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.acceptCharsetHeader: "utf-8"
      },
      body: jsonEncode({
        "input": Uri.parse(input).toString(),
        "sessiontoken": sessionTokenString,
      })
    );

    if (response.statusCode == 200) {
      final result = json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (result["status"] == "OK") {
        final List<Suggestion> suggestions = [];
        final List<Map<String, dynamic>> suggestionsMaps = (result["predictions"] as List<dynamic>).cast<Map<String, dynamic>>();

        for (final map in suggestionsMaps) {
          suggestions.add(Suggestion(map["place_id"] as String, map["description"] as String));
        }

        return suggestions;
      }

      if (result["status"] == "ZERO_RESULTS") {
        return [];
      }

      throw Exception(result["error_message"]);
    }

    throw Exception("Failed to fetch suggestion");
  }

  Future<LatLng?> latLgnForAddress(String address) async {
    final String sessionToken = const Uuid().v4();

    final List<Suggestion> suggestions = await fetchSuggestions(address, "fr", sessionToken);

    if (suggestions.isEmpty) {
      return null;
    }

    final response = await http.post(
      Uri.parse("$kRESTApiBaseUrl/maps/details"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode({
        "placeID": suggestions.first.placeId,
        "sessiontoken": sessionToken,
      })
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body) as Map<String, dynamic>;
      if (result["status"] == "OK") {
        final double lat = result["result"]["geometry"]["location"]["lat"] as double;
        final double lng = result["result"]["geometry"]["location"]["lng"] as double;

        return LatLng(lat, lng);
      }
    } 

    return null;
  }

  Future<Address?> detailsForAddress(String address) async {
    final String sessionToken = const Uuid().v4();

    final List<Suggestion> suggestions = await fetchSuggestions(address, "fr", sessionToken);

    if (suggestions.isEmpty) {
      return null;
    }

    final response = await http.post(
      Uri.parse("$kRESTApiBaseUrl/maps/details"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode({
        "placeID": suggestions.first.placeId,
        "sessiontoken": sessionToken,
      })
    );

    if (response.statusCode == 200) {
      final result = json.decode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      if (result["status"] == "OK") {
        final List<Map<String, dynamic>> components = (result["result"]["address_components"] as List<dynamic>).cast<Map<String, dynamic>>();

        String? number;
        String? route;
        String? postalCode;
        String? city;

        for (final component in components) {
          final List<String> types = (component["types"] as List<dynamic>).cast<String>();

          if (types.contains("street_number")) {
            number = component["long_name"] as String;
          }

          if (types.contains("route")) {
            route = component["long_name"] as String;
          }

          if (types.contains("postal_code")) {
            postalCode = component["long_name"] as String;
          }

          if (types.contains("locality")) {
            city = component["long_name"] as String;
          }

        }

        return Address(
          number: number,
          route: route,
          postalCode: postalCode,
          city: city
        );
      }
    } 

    return null;
  }
}