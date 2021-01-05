import 'package:flutter/foundation.dart';

class StoreProvider extends ChangeNotifier {
  Map<String, int> cart = {"1": 4};
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
    return cart.length;
  }

  int quantityOfProduct(String productID) {
    return cart[productID];
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
}
