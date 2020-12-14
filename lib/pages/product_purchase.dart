import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zukes/models/r_paymetnResponse.dart';
import 'package:zukes/widgets/payment_bottomSheet.dart';

class ProductPage extends StatefulWidget {
  ProductPage(
      {Key key,
      @required this.productID,
      this.productName,
      this.amount,
      this.imageURL})
      : super(key: key);
  final String productID;
  final String productName;
  final String amount;
  final String imageURL;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double slide = 0;
  @override
  void initState() {
    super.initState();
    slide = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.card_travel),
              onPressed: () {},
            ),
          ],
          title: Center(
              child: Text("ICRIB \nSTORE",
                  style: TextStyle(color: Color(0xff1a1a49)))),
          backgroundColor: Color(0xfffecf0a)),
      bottomNavigationBar: Card(
        child: Container(
            decoration: BoxDecoration(),
            height: 50,
            child: Row(
              children: [
                Hero(
                  tag: 'button1',
                  child: Container(
                      padding: EdgeInsets.only(left: 8.0, right: 8.0),
                      width: 90,
                      height: 50,
                      color: Color(0xfffecf0a),
                      child: InkWell(
                        onTap: () {
                          settingModalBottomSheet(context, "3");
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
                Spacer(),
                Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    width: 120,
                    height: 100,
                    child: Row(
                      children: [
                        Text("KSH 0", style: TextStyle(fontSize: 24)),
                        Spacer(),
                        Icon(Icons.card_travel),
                      ],
                    )),
              ],
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bamburi Cement",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("1kg x 20 Packets"),
                Text("KSH 2138/Bale"),
                SizedBox(height: 20),
                Center(
                  child: Image.network(
                    "https://shop.twiga.ke/static/758a50c7e869e88ff7eb52f10026a422/8ea22/0e9f0f9f-2773-4f95-b03d-7fc977a87093.webp",
                    width: 300,
                    height: 300,
                  ),
                ),
                SizedBox(height: 20),
                Text("Enter Quanity in Bales"),
                Slider(
                  value: slide,
                  onChanged: (double value) {
                    setState(() {
                      slide = value;
                    });
                    //print(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void settingModalBottomSheet(context, amountDue) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
    ),
    context: context,
    builder: (BuildContext context) {
      return PaymentBottomSheet();
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
          )),
    );
  }
}
