import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:zukes/pages/login/otp_new_page.dart';
import 'package:zukes/pages/login/termPage.dart';
import 'package:zukes/providers/login_data.dart';

class AcceptTerms extends StatelessWidget {
  final String phone;
  final String initals;
  final String name;

  const AcceptTerms(
      {Key key, @required this.phone, @required this.initals, this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(
              top: 16.0, bottom: 16.0, left: 14.0, right: 14.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(color: Colors.green)),
            padding: EdgeInsets.all(8.0),
            color: Colors.green,
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => ChangeNotifierProvider<LoginData>(
                      create: (context) => LoginData(),
                      child: AnnotatedRegion<SystemUiOverlayStyle>(
                          value: SystemUiOverlayStyle(
                              statusBarColor: Colors.white,
                              systemNavigationBarColor: Colors.white),
                          child: OtpNewForm(
                            initals: initals,
                            name: name,
                            phone: phone,
                          )))));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 8),
                  child: Text("CONTINUE",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.grey,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              CircleAvatar(
                  minRadius: 30,
                  backgroundColor: Color(0xfffe8fcfa),
                  child: Text("$initals")),
              SizedBox(height: 2),
              Text(
                "$name",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 3),
              Text("$phone"),
              Spacer(),
              //Add animation to turn to scratch card then submit to verify
              Row(children: [
                // lstore.buttonStates.forEach((k) => Text('$k')),
                Spacer(),
                Container(
                    height: 180,
                    width: 140,
                    child: FlareActor(
                      'assets/licen.flr',
                      alignment: Alignment.center,
                      fit: BoxFit.contain,
                      animation: "runner",
                    )),
                Spacer(),
              ]),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                width: MediaQuery.of(context).size.width,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                          text:
                              "By tapping \"Continue\" you acknowledge that you have read the"),
                      TextSpan(
                        text: " Privacy Policy ",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                settings: RouteSettings(),
                                builder: (ctx) =>
                                    AnnotatedRegion<SystemUiOverlayStyle>(
                                        value: SystemUiOverlayStyle(
                                            statusBarColor: Colors.white,
                                            systemNavigationBarColor:
                                                Colors.white),
                                        child: TermsAndConditonsWebView())));
                          },
                      ),
                      TextSpan(
                        text: "and agree to the",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(CupertinoPageRoute(
                                settings: RouteSettings(),
                                builder: (ctx) =>
                                    AnnotatedRegion<SystemUiOverlayStyle>(
                                        value: SystemUiOverlayStyle(
                                            statusBarColor: Colors.white,
                                            systemNavigationBarColor:
                                                Colors.white),
                                        child: TermsAndConditonsWebView())));
                          },
                        text: " Terms and Conditions ",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
