import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future getAllCategories(BuildContext ctx) async {
  try {
    final response = await http.get(
      ("http://store.i-crib.co.ke/" + "categories"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    var myjson = json.decode(response.body);
    //print(myjson);
    return myjson;
  } catch (SocketException) {
    print("Could not fetch data");
  }
}
