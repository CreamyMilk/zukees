import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AcceptTerms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(bottom: 16.0, left: 8.0, right: 8.0),
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.green)),
            padding: EdgeInsets.all(8.0),
            color: Colors.green,
            onPressed: () {
              Navigator.of(context).pushNamed('/t');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                Text("Continue", style: TextStyle(color: Colors.white)),
                Spacer(),
                Icon(
                  Icons.arrow_forward,
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
              Row(children: [Icon(Icons.arrow_back, color: Colors.grey)]),
              CircleAvatar(
                  minRadius: 35,
                  backgroundColor: Color(0xfffe8fcfa),
                  child: Text("JK")),
              SizedBox(height: 2),
              Text("Jotham Kinyua"),

              SizedBox(height: 3),
              Text("+254797678252"),
              Spacer(),

              //Add animation to turn to scratch card then submit to verify

              Row(children: [
                // lstore.buttonStates.forEach((k) => Text('$k')),
                Spacer(),
                Container(color: Colors.green),
                Spacer(),
              ]),
              SizedBox(
                height: 100,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text:
                          "By tapping Continue you acknowledge that you have read the"),
                  TextSpan(
                    text: " PrivacyPolicy ",
                    style: TextStyle(color: Colors.green),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamed("/termspage");
                      },
                  ),
                  TextSpan(text: "and agree to the"),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamed("/termspage");
                        },
                      text: "Terms and Conditions ",
                      style: TextStyle(color: Colors.green)),
                ])),
              ),
            ],
          ),
        ));
  }
}
