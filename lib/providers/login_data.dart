import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginData extends ChangeNotifier {
  String pin = "";
  String phoneNumber = "";
  String message = "ENTER RECEIVED SMS PIN";
  Color messageColor = Colors.black;
  List<bool> buttonStates = [false, false, false, false];
  int pointer = 0;
  bool complete = false;

  void backspace() {
    if (pin.length == 4) {
      complete = false;
      message = "ENTER RECEIVED SMS PIN";
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
      message = "ENTER RECEIVED SMS PIN";
      pointer = 0;
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
      sendLogin(phoneNumber, pin);
      message = "Validating Pin ...";
      messageColor = Colors.green;
      complete = true;
      notifyListeners();
    }
  }

  void setPhone(String value) {
    phoneNumber = value;
  }

  Future sendLogin(String phone, String pin) async {
    try {
      final response = await http.post(
        ("http://land.i-crib.co.ke/" + "verify"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          {"phone": phone, "pin": pin},
        ),
      );
      var myjson = json.decode(response.body);
      if (myjson["message"] == 2 || myjson["message"] == 3) {
        successfulLogin(myjson);
      } else {
        submit();
        message = "Please Try Again";
        messageColor = Colors.red;
        notifyListeners();
        Future.delayed(
            Duration(
              seconds: 3,
            ), () {
          message = "ENTER RECEIVED SMS PIN";
          messageColor = Colors.black;
          notifyListeners();
        });
        print("error");
      }
    } catch (SocketException) {
      message = "NO STABLE NETWORK";
      messageColor = Colors.black;
      notifyListeners();
    }
  }
}

Future successfulLogin(response) async {
  final prefs = await SharedPreferences.getInstance();
  cacheUserData(response);
  prefs.setString("user_token", "0").then((bool success) {
    if (success) {
      print("Token Stored Successfully");
      Navigator.of(null).pushReplacementNamed('/home');
    } else {
      //Show that storage
    }
  });
}

Future cacheUserData(apidata) async {
  final userHiveBox = Hive.box('user');
  print("AAPI$apidata");
  userHiveBox.put("fire_store", apidata["fire_store"]);
  userHiveBox.put("name", apidata["name"]);
  userHiveBox.put("mobile", apidata["mobile"]);
  userHiveBox.put("timeu", DateFormat("hh:mm a").format(DateTime.now()));
  userHiveBox.put("tenants", apidata["total_tenants"]["total"]);
  userHiveBox.put("vaccant", apidata["vaccant_houses"]["total"]);
  print("Inserting login info");
}
