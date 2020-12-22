import 'package:flutter/foundation.dart';

class RentAmountP extends ChangeNotifier {
  double paid = 0;
  double due = 0;
  void updateValues(double x, double y) {
    paid = x;
    due = y;
    notifyListeners();
  }
}
