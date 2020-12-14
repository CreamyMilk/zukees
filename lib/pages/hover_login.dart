import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zukes/providers/counter.dart';

class HoverLogin extends StatefulWidget {
  HoverLogin({Key key}) : super(key: key);

  @override
  _HoverLoginState createState() => _HoverLoginState();
}

class _HoverLoginState extends State<HoverLogin> {
  bool isLoggedIn;
  final FocusNode fnOne = FocusNode();
  final FocusNode fnTwo = FocusNode();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final typeController = TextEditingController();
  final descController = TextEditingController();
  bool _loading;
  void validateForm() {
    if (formkey.currentState.validate()) {
      var ty = typeController.text;
      var ds = descController.text;
      sendLogin(ty, ds, context);
    }
  }

  @override
  void initState() {
    _loading = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hstore = Provider.of<Counter>(context);

    getStartUpPage(context);
    double h = hstore.value;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () {
      //   hstore.increment();
      //   // print(MediaQuery.of(context).viewInsets.bottom);
      //   // setState(() {
      //   //   h = 0.5;
      //   // });
      //   //Navigator.of(context).pushNamed('/home');
      // }),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
                duration: Duration(seconds: 2),
                color: Colors.black,
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
                        color: Colors.white,
                        size: 150,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: h == 0.0
                          ? LinearProgressIndicator(
                              backgroundColor: Colors.black,
                            )
                          : Center(
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.healing,
                    //     color: Colors.white,
                    //     size: 150,
                    //   ),
                    //   onPressed: () {
                    //     hstore.decrement();
                    //     print(h);
                    //   },
                    // ),
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
                        key: formkey,
                        child: Column(
                          children: [
                            TextFormField(
                              onFieldSubmitted: (term) {
                                fnOne.unfocus();
                                FocusScope.of(context).requestFocus(fnTwo);
                              },
                              focusNode: fnOne,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Required";
                                } else {
                                  return null;
                                }
                              },
                              controller: typeController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                //hintText: 'Kindly enter a category',
                                //helperText: 'PhoneNumber +254xxx',
                                labelText: 'PhoneNumber',
                              ),
                              maxLines: 1,
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              focusNode: fnTwo,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Required";
                                } else {
                                  return null;
                                }
                              },
                              controller: descController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Pin Sent to your number',
                                labelText: 'Password',
                              ),
                              maxLines: 1,
                            ),
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
                            setState(() {
                              _loading = false;
                            });
                          },
                          child: Text("Cancel"),
                        ),
                        Spacer(),
                        Hero(
                          tag: 'report',
                          child: MaterialButton(
                            color: !_loading ? Colors.deepOrange : Colors.black,
                            onPressed: () {
                              validateForm();
                              setState(() {
                                if (formkey.currentState.validate()) {
                                  _loading = true;
                                }
                              });
                            },
                            child: Text(
                              !_loading ? "Sign In" : "Loading...",
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

Future sendLogin(phone, password, context) async {
  try {
    final response = await http.post(
      ("http://land.i-crib.co.ke/" + "verify"),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: jsonEncode(
        {"phone": phone, "otp": password},
      ),
    );
    var myjson = json.decode(response.body);
    if (myjson["response-code"] == 1) {
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
      //Navigator.of(context).pushNamed('/home');
    } else {
      //Show that storage
    }
  });
}

Future cacheUserData(apidata) async {
  final userHiveBox = Hive.box('user');
  print("AAPI$apidata");
  //var newtrans = apidata["transaction"];
  //userHiveBox.put("transaction", jsonEncode(newtrans));
  userHiveBox.put("fire_store", apidata["fire_store"]);
  userHiveBox.put("name", apidata["name"]);
  userHiveBox.put("tenants", apidata["total_tenants"]["total"]);
  userHiveBox.put("vaccant", apidata["vaccant_houses"]["total"]);
  //userHiveBox.putAll(apidata);
  print("Inserting login info");
}

Future getStartUpPage(BuildContext context) async {
  print("Reading Shared Prefs");
  final hstore = Provider.of<Counter>(context);
  final prefs = await SharedPreferences.getInstance();
  final userToken = prefs.getString('user_token') ?? "";
  //final userTrans = prefs.getString('user_transactions') ?? "no";
  //_cacheUserDetails(userTrans);
  print("UserToken ilikuwa $userToken");
  Future.delayed(Duration(seconds: 3), () {
    userToken == "0"
        ? Navigator.of(context).pushNamed('/home')
        : hstore.showlogs();
  });
}
