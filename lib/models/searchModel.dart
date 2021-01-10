import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'place.dart';

class SearchModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Place> _suggestions = history;
  List<Place> get suggestions => _suggestions;

  String _query = '';
  String get query => _query;

  void onQueryChanged(String query) async {
    if (query == _query) return;

    _query = query;
    _isLoading = true;
    notifyListeners();

    if (query.isEmpty) {
      _suggestions = history;
    } else {
      final response =
          await http.get('https://store.i-crib.co.ke/search?q=$query');
      final body = json.decode(utf8.decode(response.bodyBytes));
      final features = body['data'] as List;
      _suggestions = [];
      for (dynamic o in features) {
        Place temp;
        temp = Place.fromJson(o);
        suggestions.add(temp);
      }
      print("Suggestions $_suggestions");
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _suggestions = [];
    notifyListeners();
  }
}

List<Place> history = [
  // Place(0,
  //     productId: 1,
  //     categoryId: 1,
  //     productName: "Nuts",
  //     productImage:
  //         "https://shop.twiga.ke/static/ac2803e0375850278fe923c52490784b/8ea22/eddacd9e-8170-4e1d-8cad-0a550d5c2a461604472076.52438.webp",
  //     productImageLarge:
  //         "https://shop.twiga.ke/static/ac2803e0375850278fe923c52490784b/8ea22/eddacd9e-8170-4e1d-8cad-0a550d5c2a461604472076.52438.webp",
  //     descriptions: "oya",
  //     amount: 13,
  //     stock: 11,
  //     productPacktype: "boxes")
];
