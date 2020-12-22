import 'package:flutter/foundation.dart';

double _paid = 0;
double _due = 0;

class RentAmountP extends ChangeNotifier {
  get paid => _paid;
  get due => _due;

  void updateValues(double x, double y) {
    _paid = x;
    _due = y;

    notifyListeners();
  }
}
