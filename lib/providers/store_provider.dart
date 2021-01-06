import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class StoreProvider extends ChangeNotifier {
  //Print I should not be initaizing the values here so add to future
  Map<String, int> cart = {};
  dynamic productDetails;
  dynamic t;
  int totalPrice = 0;
  int toalNumberofProducts = 0;
  void addToCart(String productID) {
    if (cart[productID] == null) {
      cart[productID] = 1;
      calculateNumberOfItems();
      notifyListeners();
    } else {
      cart[productID] = cart[productID] + 1;
      calculateNumberOfItems();
      notifyListeners();
    }
  }

  void removeFromCart(String productID) {
    cart.remove(productID);
    notifyListeners();
  }

  void decrementFromCart(String productID) {
    if (cart[productID] == null) {
      print("Tried to decrement value that is out of view");
    } else if (cart[productID] == 0) {
      print("Product is already at the minimum 0");
    } else {
      cart[productID] = cart[productID] - 1;
      calculateNumberOfItems();
      notifyListeners();
    }
  }

  void calculateNumberOfItems() {
    int temp = 0;
    final productQuantities = cart.values;
    for (int v in productQuantities) {
      temp += v;
    }
    toalNumberofProducts = temp;
    notifyListeners();
  }

  int numberOfProducts() {
    return toalNumberofProducts;
  }

  int quantityOfProduct(String productID) {
    if (cart[productID] == null) {
      cart[productID] = 0;

      notifyListeners();
      return cart[productID];
    } else {
      return cart[productID];
    }
  }

  void totalPriceCalc() {
    totalPrice = 0;
    cart.forEach((key, value) {
      //Do a llok up in hive or sql
      int unitCost = 23;
      totalPrice += (value * unitCost);
    });
    notifyListeners();
  }

  void addProductDetails() {
    Map<String, String> products;
    for (dynamic product in productDetails) {
      products[product["product_id"].toString()] = product;
    }
    productDetails = products;
    notifyListeners();
    print(
        "#########################################Stored products into Hive#################################################");
  }

  Future getAllProducts() async {
    try {
      final response = await get(
        ("http://store.i-crib.co.ke/" + "products"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
      );
       productDetails = json.decode(response.body);
      return productDetails;
    } catch (SocketException) {
      print("Could not fetch data");
    }
  }

}
