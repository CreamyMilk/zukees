import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sms_autofill/sms_autofill.dart';
import 'package:sms_consent/sms_consent.dart';

class OtpReceiver extends StatefulWidget {
  final phonenumber;
  OtpReceiver({
    Key key,
    @required this.phonenumber,
  }) : super(key: key);
  @override
  _OtpReceiverState createState() => _OtpReceiverState();
}

class _OtpReceiverState extends State<OtpReceiver> {
  String _receivedCode = '';
  @override
  void initState() {
    super.initState();
    initSMSState();
  }

  Future<void> initSMSState() async {
    String receivedCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      String temp = await SmsConsent.startSMSConsent();
      receivedCode = temp.substring(0, 4);
    } on PlatformException {
      receivedCode = '';
    }
    if (!mounted) return;
    setState(() => _receivedCode = receivedCode);
  }

  @override
  void dispose() {
    SmsConsent.stopSMSConsent();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Please wait for activation code sent to your \nphone number",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "${widget.phonenumber}",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.blue),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 10,
            ),
            child: PinFieldAutoFill(
              currentCode: _receivedCode,
              autofocus: false,
              codeLength: 4,
              onCodeChanged: (val) {
                print(val);
                if (val.length == 4) {
                  Flushbar(message: "🔐 Verifying OTP...")..show(context);
                  print("doing some naviagion here $val");
                  //confirmOTP(widget.phonenumber, val, context);
                  //Navigator.of(context).pop();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  // void _listenforOTP() async {
  //   await SmsAutoFill().listenForCode;
  // }
}
