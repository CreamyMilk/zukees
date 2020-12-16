import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class KraFormProvider extends ChangeNotifier {
  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  TextEditingController yController = TextEditingController();
  TextEditingController mController = TextEditingController();
  TextEditingController dController = TextEditingController();
  GlobalKey<FormState> birthKey = GlobalKey<FormState>();
  TextEditingController cnController = TextEditingController();
  TextEditingController phController = TextEditingController();
  GlobalKey<FormState> phoneKey = GlobalKey<FormState>();
  GlobalKey<FormState> kraKey = GlobalKey<FormState>();
  int activePage = 0;
  String firstName = "Jotham";
  String lastName;
  String day;
  String month;
  String year;
  String countrycode;
  String phoneNumber;
  String krapin;
  bool terms = false;

  void nameFields(String a, String b) {
    firstName = a;
    lastName = b;
    notifyListeners();
  }

  void ageFields(String d, String m, String y) {
    day = d;
    month = m;
    year = y;
    notifyListeners();
  }

  void kraFields(String t) {
    krapin = t;
    notifyListeners();
  }

  void increment() {
    activePage++;
    notifyListeners();
  }

  void decrement() {
    activePage--;
    notifyListeners();
  }

  void nfSubmit() {
    if (nameKey.currentState.validate()) {
      firstName = fnController.text;
      lastName = lnController.text;
      increment();
      //print("Text fiels Values are $t $d");
    }
  }

  void bfSubmit() {
    if (birthKey.currentState.validate()) {
      year = yController.text;
      month = mController.text;
      day = dController.text;
      increment();
      //print("Text fiels Values are $t $d");
    }
  }

  void phSubmit() {
    if (phoneKey.currentState.validate()) {
      countrycode = cnController.text;
      phoneNumber = phController.text;
      increment();
      //print("Text fiels Values are $t $d");
    }
  }

  void krSubmit() {
    if (krapin.length > 6) {
      increment();
    }
    //print("Text fiels Values are $t $d");
  }

  void termsAccept(value) {
    terms = value;
    notifyListeners();
  }
}
