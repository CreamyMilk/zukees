import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zukes/pages/login/acceptTerms.dart';
import 'package:zukes/providers/counter.dart';

class HoverLogin extends StatefulWidget {
  @override
  _HoverLoginState createState() => _HoverLoginState();
}

class _HoverLoginState extends State<HoverLogin> {
  @override
  void initState() {
    super.initState();
  }

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final typeController = TextEditingController();

  void validateForm() {
    if (_formkey.currentState.validate()) {
      String ty = typeController.text;
      sendLogin(ty, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hstore = Provider.of<Counter>(context);
    getStartUpPage(hstore, context);
    double h = hstore.value;
    bool loading = hstore.loading;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
                duration: Duration(seconds: 3),
                color: Colors.white,
                height: MediaQuery.of(context).size.height * (1 - h),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Hero(
                      tag: "heal",
                      child: Icon(
                        Icons.healing,
                        color: Colors.black,
                        size: 60,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: h == 0.0
                          ? LinearProgressIndicator(
                              backgroundColor: Colors.black,
                            )
                          : Center(
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                    ),
                  ],
                )),
            AnimatedContainer(
              duration: Duration(seconds: 2),
              padding: EdgeInsets.only(left: 10, right: 10),
              color: Colors.white,
              height: MediaQuery.of(context).size.height * (h),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40),
                    Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              onFieldSubmitted: (term) {
                                print(term);
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Required";
                                } else {
                                  return null;
                                }
                              },
                              controller: typeController,
                              maxLength: 10,
                              keyboardType:
                                  TextInputType.numberWithOptions(signed: true),
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                //hintText: 'Kindly enter a category',
                                //helperText: 'PhoneNumber +254xxx',
                                labelText: 'PhoneNumber',
                              ),
                              maxLines: 1,
                            ),
                            SizedBox(height: 30),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        OutlineButton(
                          color: Colors.grey,
                          onPressed: () {
                            //Navigator.of(context).pushNamed('/home');
                            hstore.loginState();
                          },
                          child: Text("Cancel"),
                        ),
                        Spacer(),
                        Hero(
                          tag: 'report',
                          child: MaterialButton(
                            color: !loading ? Colors.deepOrange : Colors.black,
                            onPressed: !loading
                                ? () {
                                    validateForm();
                                    if (_formkey.currentState.validate()) {
                                      hstore.loginState();
                                    }
                                  }
                                : () {
                                    print("Button seems to be offline");
                                  },
                            child: Text(
                              !loading ? "Sign In" : "Loading...",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        //Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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

class TermsRouteArguments {
  final String phoneNumber;
  final String name;
  final String initals;

  TermsRouteArguments({this.phoneNumber, this.name, this.initals});
}

Future successfulLogin(response, context) async {
  final t = response["data"];
  final name = t["name"];
  final initals = t["initals"];
  final phoneNumbet = t["number"];
  Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
          settings: RouteSettings(),
          builder: (ctx) => AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  systemNavigationBarColor: Colors.white),
              child: AcceptTerms(
                initals: initals,
                name: name,
                phone: phoneNumbet,
              ))));
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

Future getStartUpPage(hstore, ctx) async {
  print("Reading Shared Prefs");
  final prefs = await SharedPreferences.getInstance();
  final userToken = prefs.getString('user_token') ?? "";
  print("UserToken ilikuwa $userToken");
  Future.delayed(Duration(seconds: 3), () {
    userToken == "0"
        ? Navigator.of(ctx).pushReplacementNamed('/home')
        : hstore.showlogs();
  });
}
