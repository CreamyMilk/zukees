import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zukes/models/r_paymetnResponse.dart';
import 'package:zukes/providers/purchaceProvide.dart';
import 'package:zukes/widgets/payment_bottomSheet.dart';

class ProductPage extends StatefulWidget {
  ProductPage(
      {Key key,
      @required this.productID,
      this.productName,
       this.amount,
      this.imageURL})
      : super(key: key);
  final int productID;
  final String productName;
  final double amount;
  final String imageURL;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final costStore = Provider.of<PurchaseData>(context);
    int prodID = widget.productID;
    String pName = widget.productName;
    Future _getProductDetails(int pID) async {
      print('Getting details for product >  $pID');
      try {
        final response = await http.post(
          ("https://store.i-crib.co.ke/productdetails"),
          headers: {
            "Accept": "application/json",
            "content-type": "application/json",
          },
          body: jsonEncode(
            {
              'product_id': pID,
            },
          ),
        );
        var myjson = json.decode(response.body);
        print("Product in detail api returned $myjson");
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
      appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.card_travel, color: Color(0xff1a1a49)),
              onPressed: () {},
            ),
          ],
          title: Center(
              child: Text("ICRIB \nSTORE",
                  style: TextStyle(color: Color(0xff1a1a49)))),
          backgroundColor: Color(0xfffecf0a)),
      bottomNavigationBar: Card(
        child: Container(
            height: 50,
            child: Row(
              children: [
                Hero(
                  tag: 'button $prodID',
                  child: InkWell(
                    onTap: () {
                      print("meme");
                    },
                    child: Container(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        width: 90,
                        height: 50,
                        color: Color(0xfffecf0a),
                        child: InkWell(
                          onTap: () {
                            settingModalBottomSheet(
                                context,
                                costStore.payableAmount.toInt(),
                                prodID,
                                pName);
                          },
                          child: Row(
                            children: [
                              Text("Buy Now"),
                              Spacer(),
                              Icon(Icons.assignment_turned_in),
                            ],
                          ),
                        )),
                  ),
                ),
                SizedBox(width:25),
		Expanded(
		flex:10,
                child:Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    height: 1000,
                    child: Row(
		mainAxisAlignment:MainAxisAlignment.end,
                      children: [
                        Text("KSH ${costStore.payableAmount}",
                            style: TextStyle(fontSize: 24)),
                        Spacer(),
                        Icon(Icons.card_travel),
                      ],
                    ))),
              ],
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
                future: _getProductDetails(prodID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(snapshot.data["product_name"],
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(snapshot.data["product_packtype"]),
                        SizedBox(height: 5),
                        Text("Ksh.${snapshot.data["amount"]}"),
                        SizedBox(height: 20),
                        Center(
                          child: CachedNetworkImage(
                            height: 300,
                            width: 300,
                            imageUrl: snapshot.data["product_image_large"],
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Choose Quanity"),
                        Text("Description ${snapshot.data["descriptions"]}"),
                        SfSlider(
                          min: 1.0,
                          max: 10.0, //snapshot.data["stock"]
                          stepSize: 1.0,
                          value: costStore.slideQuantity.toDouble(),
                          interval:1.0,
                          showTicks: true,
                          showLabels: true,
                          enableTooltip: true,
                          //minorTicksPerInterval: 1,
                          onChanged: (dynamic value) {
                            costStore.update(value);
                          },
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      color: Colors.white,
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}

void settingModalBottomSheet(
    BuildContext context, int amountDue, int _productID, String _prodName) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
    ),
    context: context,
    builder: (BuildContext context) {
      return PaymentBottomSheet(
        amount: amountDue,
        productID: _productID,
        productName: _prodName,
      );
    },
  );
}

Future sendPayment(mobile, amountDue, accName, ctx) async {
  //final FirebaseMessaging _fcm = FirebaseMessaging();
  //v2 work with paymentapi responses
  PaymentResponse data;
  try {
    final response = await http.post(
      ("https://googlesecureotp.herokuapp.com/" + "payment"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        //ensure that the user has bothe the socketID and the USER ID
        {
          "phonenumber": mobile,
          "amount": amountDue,
          "userID": accName ?? "Error",
          "socketID": "mee",
          "notifToken": "productToken"
        },
      ),
    );
    print("$accName");
    var myjson = json.decode(response.body);
    print("productToken");
    data = PaymentResponse.fromJson(myjson);
    print(data.paymentCode);
    print(data.description);
  } catch (SocketException) {
    print("msEE HAUNA WIFI");
    showDialog(
      //Text(message['notification']['title']
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: Text("dfdf"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("It seems that you are offline"),
          ],
        ),
      ),
    );
  }
}
