import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:zukes/providers/counter.dart';

class HoverLogin extends StatefulWidget {
  HoverLogin({Key key}) : super(key: key);

  @override
  _HoverLoginState createState() => _HoverLoginState();
}

class _HoverLoginState extends State<HoverLogin> {
  bool isLoggedIn;
  FocusNode secFocusNode;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final typeController = TextEditingController();
  final descController = TextEditingController();
  bool _loading;
  void validateForm() {
    if (formkey.currentState.validate()) {
      var ty = typeController.text;
      var ds = descController.text;
      sendComplain(ty, ds, context);
    }
  }

  @override
  void initState() {
    secFocusNode = FocusNode();
    _loading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hstore = Provider.of<Counter>(context);

    double h = hstore.value;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        hstore.increment();
        // print(MediaQuery.of(context).viewInsets.bottom);
        // setState(() {
        //   h = 0.5;
        // });
        //Navigator.of(context).pushNamed('/home');
      }),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
                duration: Duration(seconds: 3),
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
                            SizedBox(height: 20),
                            TextFormField(
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
                      height: 10,
                    ),
                    Row(
                      children: [
                        OutlineButton(
                          color: Colors.grey,
                          onPressed: () {
                            Navigator.of(context).pushNamed('/home');
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

Future sendComplain(phone, password, context) async {
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

    print(myjson);
    Flushbar(
      message: myjson,
    )..show(context);
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
