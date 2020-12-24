import 'package:flutter/foundation.dart';

class OtpDataProvide extends ChangeNotifier {
  String number = "07";
  bool complete = false;

  void backspace() {
    if (number.length > 0) {
      number = number.substring(0, number.length - 1);
      notifyListeners();
    }
  }

  void submit() {
    if (number.length >= 10) {
      complete = !complete;
      notifyListeners();
    }
  }

  void typing(String value) {
    if (number.length < 10) {
      number += value;
      notifyListeners();
    } else if (number.length == 10) {
      complete = !complete;
      notifyListeners();
    }
  }
}
