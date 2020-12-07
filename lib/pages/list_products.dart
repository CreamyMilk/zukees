import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:http/http.dart' as http;

class ListProducts extends StatelessWidget {
  const ListProducts({Key key, @required this.category}) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    Future _getProducts(String category) async {
      print('Fetching  $category products');
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

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: _getProducts(category),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: 500,
                  child: FutureBuilder(
                      future: null,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 4,
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.8,
                                      crossAxisSpacing: 8),
                              padding: EdgeInsets.all(8.0),
                              itemCount: 16, //snapshot.data.length ,
                              itemBuilder: (context, index) {
                                return ProductListingItem(
                                  heros:index,
                                  prodname: "Cement \n\n",
                                  imageUrl:
                                     "https://dms-products.twiga.tech/product_items_PRODUCTION/14ae20ef-4dd0-4650-baec-266432910c791592550391.462305.jpg",
                                  productID: "900",
                                );
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                );
              } else {
                return Container(
                  child: Text("No API data fetched yet"),
                );
              }
            }),
      ),
    );
  }
}

class ProductListingItem extends StatelessWidget {
  const ProductListingItem(
      {Key key, this.prodname, this.imageUrl, this.productID,this.heros})
      : super(key: key);
  final String prodname;
  final String imageUrl;
  final String productID;
  final int heros;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children:[ Container(height:150,color:Colors.transparent,child:BlurHash(
        color:Colors.transparent,
                  hash: """LXP~\$byZ?aM|_4x]R%Vs%OX3RQt6""", image: imageUrl)          ),
                  Spacer(),
                  Text("Weetabix",style:TextStyle(fontWeight:FontWeight.bold)),
                  Text("24(9090) - 1 Carton"),
          Hero(
            tag:"button$heros",
                      child: MaterialButton(color:Color(0xff1a1a49),onPressed:(){
              Navigator.of(context).pushNamed("/product",arguments:prodname );
            },child: Text("Buy Now",style:TextStyle(fontSize:14.4,fontFamily:'Poppins',color:Colors.white)),),
          ),SizedBox(height:5)]),
    );
  }
}

