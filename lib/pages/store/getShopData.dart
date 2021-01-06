import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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

Future getAllProducts(BuildContext ctx) async {
  try {
    final response = await http.get(
      ("http://store.i-crib.co.ke/" + "products"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
    );
    var myjson = json.decode(response.body);
    //Parse the output and store in hive appropriate;d
    //Yani products["1"] = {return the array}
    storeProductsInHive(myjson);
    //print(myjson);
    return myjson;
  } catch (SocketException) {
    print("Could not fetch data");
  }
}

void storeProductsInHive(jsonBlob) {
  final productsBox = Hive.box('user');
  Map<String, String> products;
  for (Map<String, dynamic> product in jsonBlob) {
    //We Enode back to string cause hive kinda trippy with hash maps and Normal Maps
    products[product["product_id"].toString()] = json.encode(product);
    productsBox.put("products", products);
    print("Stored products into Hive");
  }
}
