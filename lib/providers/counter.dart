import 'package:flutter/foundation.dart';

class Counter extends ChangeNotifier {
  double value = 0.0;
  bool loading = false;

  void increment() {
    if (value < 1.0) {
      value += 0.5;
      notifyListeners();
    }
  }

  void showlogs() {
    if (value != 0.3) {
      value += 0.3;
      notifyListeners();
    }
  }

  void loginState() {
    loading = !loading;
    notifyListeners();
  }

  void decrement() {
    if (value > 0.0) {
      value -= 0.3;
      notifyListeners();
    }
  }
}
