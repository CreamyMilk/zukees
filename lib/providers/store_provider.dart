import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class StoreProvider extends ChangeNotifier {
  //Print I should not be initaizing the values here so add to future

  Map<String, dynamic> cart = {

  };
  dynamic productDetails;
  int totalPrice = 0;
  int toalNumberofProducts = 0;

  void addToCart(String productID) {
    final productDetail = getProductDetails(productID);
    if (cart[productID] == null) {
      cart[productID] = {
        "quantity": 1,
        "details": productDetail,
      };
      
       calculateNumberOfItems();
      notifyListeners();
    } else {
      cart[productID] = {
        "quantity": cart[productID]["quantity"] + 1,
        "details": productDetail,
      };

      calculateNumberOfItems();
      notifyListeners();
    }
  }

  void removeFromCart(String productID) {
    cart.remove(productID);
      calculateNumberOfItems();
      notifyListeners();
  }

  void decrementFromCart(String productID) {
        final productDetail = getProductDetails(productID);
    if (cart[productID]["quantity"] == null) {
      print("Tried to decrement value that is out of view");
    } else if (cart[productID]["quantity"] == 0) {
      print("Product is already at the minimum 0");
    } else {
            cart[productID] = {
        "quantity": cart[productID]["quantity"] - 1,
        "details": productDetail,
      };
      calculateNumberOfItems();
      notifyListeners();
    }
  }

  void calculateNumberOfItems() {
    int temp = 0;
    final productQuantities = cart.values;
    for (Map<String, dynamic> v in productQuantities) {
      temp += v["quantity"];
    }
    toalNumberofProducts = temp;
    notifyListeners();
  }

  int numberOfProducts() {
    return toalNumberofProducts;
  }

  int quantityOfProduct(String productID) {
    if (cart[productID] == null) {
      cart[productID] = {"quantity": 0, "details": null};
      notifyListeners();
      return cart[productID]["quantity"];
    } else {
      return cart[productID]["quantity"];
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

  dynamic getProductDetails(String prodID) {
    dynamic response ;
    for (dynamic v in productDetails) {
      if (v["product_id"].toString() == prodID) {
        if(response ==null){
          response= v;
        }
      } 
    }
    return response;
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
