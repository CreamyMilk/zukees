import 'package:flutter/foundation.dart';

class Counter extends ChangeNotifier {
  double value = 0.0;

  void increment() {
    value += 0.5;
    notifyListeners();
  }

  void decrement() {
    value -= 0.5;
    notifyListeners();
  }
}
