import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AcceptTerms extends StatelessWidget {
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
            color: Colors.green[200],
            onPressed: () {
              Navigator.of(context).pushNamed('/t');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Spacer(),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text("CONTINUE",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
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
                width: MediaQuery.of(context).size.width,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                          text:
                              "By tapping \"Continue\" you acknowledge that you have read the"),
                      TextSpan(
                        text: " Privacy Policy ",
                        style: TextStyle(
                            color: Colors.green[300],
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed("/termspage");
                          },
                      ),
                      TextSpan(
                        text: "and agree to the",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed("/termspage");
                          },
                        text: "Terms and Conditions ",
                        style: TextStyle(
                            color: Colors.green[100],
                            fontSize: 13,
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
