import 'package:flutter/foundation.dart';

class StoreProvider extends ChangeNotifier {
  Map<String, int> cart = {"1": 0};
  int total = 0;
  void addToCart(String productID) {
    if (cart[productID] == null) {
      cart[productID] = 1;
      notifyListeners();
    } else {
      cart[productID] = cart[productID] = 1 + 1;
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
      notifyListeners();
    }
  }

  double numberOfItems() {
    double temp = 0;
    final productQuantities = cart.keys;
    for (String v in productQuantities) {
      temp += double.parse(v);
    }
    return temp;
  }

  int numberOfProducts() {
    return cart.length;
  }

  int quantityOfProduct(String productID) {
    return cart[productID];
  }

  void totalPrice() {
    total = 0;
    cart.forEach((key, value) {
      //Do a llok up in hive or sql
      int unitCost = 23;
      total += (value * unitCost);
    });
  }
}
