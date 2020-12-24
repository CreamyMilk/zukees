import 'package:flutter/foundation.dart';

class LoginData extends ChangeNotifier {
  String pin = "";
  List<bool> buttonStates = [false, false, false, false];
  int pointer = 0;
  bool complete = false;

  void backspace() {
    if (pin.length > 0) {
      pin = pin.substring(0, pin.length - 1);
      notifyListeners();
    }
  }

  void submit() {
    if (pin.length == 4) {
      complete = !complete;
      notifyListeners();
    }
  }

  void typing(String value) {
    if (pin.length < 4) {
      pin += value;
      notifyListeners();
    } else {
      //Symbit the value or trigger loading
      complete = !complete;
      notifyListeners();
    }
  }
}
