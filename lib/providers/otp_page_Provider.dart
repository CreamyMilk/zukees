import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

Future sendLogin(phone, context) async {
  try {
    final response = await http.post(
      ("http://land.i-crib.co.ke/" + "attemptlogin"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        {
          "phone": phone,
        },
      ),
    );
    var myjson = json.decode(response.body);
    if (myjson["message"] == 2 || myjson["message"] == 3) {
      successfulLogin(myjson, context);
    } else {
      Flushbar(
        duration: Duration(seconds: 2),
        messageText: Text(
          "${myjson["description"]}",
          style: TextStyle(color: Colors.white),
        ),
      )..show(context);
    }
  } catch (SocketException) {
    showDialog(
      //Text(message['notification']['title']
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error on Submittion"),
        content: Text("Please try later with a stable\nConnection."),
        actions: [
          MaterialButton(
            child: Text("Close", style: TextStyle(color: Colors.white)),
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
              //Navigator.of(context).pushNamed('/home');
            },
          ),
        ],
      ),
    );
  }
}

Future successfulLogin(response, context) async {
  final prefs = await SharedPreferences.getInstance();
  cacheUserData(response);
  prefs.setString("user_token", "0").then((bool success) {
    if (success) {
      print("Token Stored Successfully");
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      //Show that storage
    }
  });
}
