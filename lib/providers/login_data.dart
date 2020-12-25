import 'package:flutter/foundation.dart';

class LoginData extends ChangeNotifier {
  String pin = "";
  List<bool> buttonStates = [false, false, false, false];
  int pointer = 0;
  bool complete = false;

  void backspace() {
    if (pin.length == 4) {
      complete = false;
      pointer--;
      pin = pin.substring(0, pin.length - 1);
      buttonStates[pointer] = false;
      notifyListeners();
    } else if (pin.length > 0) {
      pointer--;
      pin = pin.substring(0, pin.length - 1);
      buttonStates[pointer] = false;
      notifyListeners();
    }
  }

  void submit() {
    if (pin.length == 4) {
      complete = !complete;
      buttonStates = [false, false, false, false];
      notifyListeners();
    }
  }

  void typing(String value) {
    if (pin.length < 3) {
      buttonStates[pointer] = true;
      pointer++;
      pin += value;
      notifyListeners();
    } else if (pin.length == 3) {
      buttonStates[pointer] = true;
      pointer++;
      pin += value;
      //Sumbit the value or trigger loading
      complete = true;
      notifyListeners();
    }
  }
}
