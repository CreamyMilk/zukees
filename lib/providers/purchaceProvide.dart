import 'package:flutter/foundation.dart';

class PurchaseData extends ChangeNotifier {
  double singleAmount = 10;
  double slideQuantity = 1;
  double payableAmount = 0;

  void update(_quan) {
    payableAmount = singleAmount * _quan;
    slideQuantity = _quan;
    notifyListeners();
  }

  void setAmount(double _val) {
	singleAmount = _val;
    notifyListeners();
}
}
