import 'dart:convert';

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

  final String apiKey = const String.fromEnvironment("MAP_PLACE_API_KEY");
  // final String apiKey = const String.fromEnvironment("MAP_PLACE_WEB_API_KEY");

  Future<List<Suggestion>> fetchSuggestions(String input, String lang, String sessionToken) async {
    final String sessionTokenString = sessionToken.isNotEmpty ? "&sessiontoken=$sessionToken" : "";

    final request = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:fr&key=$apiKey$sessionTokenString";
    final response = await http.get(
      Uri.parse(request)
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body) as Map<String, dynamic>;
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

    final request = "https://maps.googleapis.com/maps/api/place/details/json?place_id=${suggestions.first.placeId}&fields=geometry&key=$apiKey&sessiontoken=$sessionToken";
    final response = await http.get(
      Uri.parse(request)
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
}