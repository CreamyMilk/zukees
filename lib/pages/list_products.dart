import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ListProducts extends StatelessWidget {
  const ListProducts({Key key,@required this.category}) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
      Future _getProducts(String category) async {
 
    print('Fetching  $category products' );
    try {
      final response = await http.post(
        ("https://kkk.i-crib.co.ke/a"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          {
            'category': category,
          },
        ),
      );
      var myjson = json.decode(response.body);
      print("Categoreis api returned $myjson");
      //print(response.body);
      return myjson;
    } catch (SocketException) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Network Error."),
                //       actions: [MaterialButton(color:Colors.black,onPressed:(){AppSettings.openWIFISettings();},child:Text("Turn on",style:TextStyle(color:Colors.white)))],));
              ));
              
    }
  }
    return FutureBuilder(
      future: _getProducts(category),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Container(
          child: Text(category),
        );
        }else{
          return Container(
          child: Text("No API data fetched yet"),
        );
        }

      }
    );
  }
}

