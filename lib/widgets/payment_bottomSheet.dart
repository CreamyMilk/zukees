import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:zukes/models/r_paymetnResponse.dart';

class PaymentBottomSheet extends StatefulWidget {
  PaymentBottomSheet({
    Key key,
    @required this.productID,
    @required this.amount,
    @required this.productName,
  }) : super(key: key);
  final int amount;
  final int productID;
  final String productName;

  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  Box<dynamic> userHiveBox;
  final TextEditingController _testcontroller = TextEditingController();
  String mobile = "";
  String visualAmount;

  @override
  void initState() {
    userHiveBox = Hive.box('user');
    // var temp = userHiveBox.get('rent',defaultValue:{'rentDue':0,'account':'err','month':"null","rentStatus":false}); //Add default for non complains
    mobile = userHiveBox.get('mobile', defaultValue: "254797678252");
    // amountDue = temp["rentDue"].toString();
    // accountName=temp["account"];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accountName = widget.productName;
    String amountDue = widget.amount.toString();
    String visualAmount = amountDue.replaceAllMapped(
        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');

    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_downward),
                  Text(
                    "Product Checkout",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  ),
                  SizedBox()
                ],
              ),
              Divider(),
              SizedBox(height: 5),
              Row(
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Amount:",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "$visualAmount",
                          style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Number:",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          mobile,
                          style: TextStyle(
                              fontWeight: FontWeight.w100, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Payment Method",
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PaymentTile(),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // PaymentTile(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Running low on Cash ?",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                ),
              ),
              TextField(
                autofocus: true,
                onChanged: (value) {
                  print(value);
                  setState(() {
                    mobile = value;
                  });
                },
                controller: _testcontroller,
                decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.contacts),
                    onPressed: () async {
                      // final PhoneContact contact =
                      //     await FlutterContactPicker.pickPhoneContact();
                      final contact = "";
                      setState(() {
                        //_testcontroller.text =convertTo07(contact.phoneNumber.number);
                        mobile = convertTo07(contact);
                      });
                    },
                  ),
                  border: OutlineInputBorder(gapPadding: 0.5),
                  hintText: 'Ask somone else to pay',
                  errorText: validatePassword(_testcontroller.text),
                  prefixText: "",
                ),
                keyboardType: TextInputType.numberWithOptions(),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: MaterialButton(
                    height: 45,
                    minWidth: MediaQuery.of(context).size.width * .95,
                    onPressed: () async {
                      Navigator.pop(context);
                      await _sendPayment(
                          mobile, visualAmount, accountName, context);
                    },
                    color: Colors.black,
                    child: Text(
                      "Pay $visualAmount",
                      style: TextStyle(color: Colors.white),
                    ),
                    autofocus: true,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String convertTo07(String f) {
  String no;
  String pl;
  String t5;
  no = f.replaceAll(new RegExp(r"\s+"), "");
  pl = no.replaceAll(new RegExp(r"\+"), "");
  t5 = pl.replaceAll(new RegExp(r"2547"), "07");
  return t5;
}

String validatePassword(String value) {
  if (!(value.length > 9) && value.isNotEmpty) {
    if (value[0] != "0") {
      return "Mobile number should be in the format 07xx";
    }
    return null;
  }
  return null;
}

Future _sendPayment(mobile, amountDue, accName, ctx) async {
  //final FirebaseMessaging _fcm = FirebaseMessaging();
  //v2 work with paymentapi responses
  PaymentResponse data;

  try {
    //String "productToken" = await _fcm.getToken();
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
    var myjson = json.decode(response.body);
    print("productToken");
    data = PaymentResponse.fromJson(myjson);
    print(data);
  } catch (SocketException) {
    print("msEE HAUNA WIFI");
    showDialog(
      //Text(message['notification']['title']
      context: ctx,
      builder: (ctx) => AlertDialog(
          title: Text("error"),
          // AspectRatio(
          //         aspectRatio: 1.5,
          //         child: FlareActor(
          //           'assets/fail.flr',
          //           alignment: Alignment.center,
          //           fit: BoxFit.contain,
          //           animation: 'Failure',
          //         ),
          //       ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("It seems that you are offline"),
            ],
          )),
    );
  }
}
