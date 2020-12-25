import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zukes/providers/login_data.dart';
import 'package:zukes/widgets/onScreenPad.dart';

class OtpNewForm extends StatelessWidget {
  final String phone;
  final String initals;
  final String name;
  OtpNewForm(
      {Key key,
      @required this.phone,
      @required this.initals,
      @required this.name})
      : super(key: key);
  final TextStyle becomeGreen = TextStyle(color: Colors.green);
  @override
  Widget build(BuildContext context) {
    final lstore = Provider.of<LoginData>(context);
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]),
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
          Text(
            !lstore.complete ? "ENTER RECEIVED SMS PIN" : "Validating Pin ...",
            style: !lstore.complete ? null : becomeGreen,
          ),
          Row(children: [
            // lstore.buttonStates.forEach((k) => Text('$k')),
            Spacer(),
            BaseBall(
              isActive: lstore.buttonStates[0],
            ),
            BaseBall(
              isActive: lstore.buttonStates[1],
            ),
            BaseBall(
              isActive: lstore.buttonStates[2],
            ),
            BaseBall(
              isActive: lstore.buttonStates[3],
            ),
            Spacer(),
          ]),
          SizedBox(
            height: 100,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: NumericKeyboard(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              onKeyboardTap: lstore.typing,
              textColor: Colors.black,
              rightIcon: Icon(
                Icons.backspace,
                color: Colors.grey,
              ),
              rightButtonFn: () {
                lstore.backspace();
              },
              leftIcon: Icon(
                !lstore.complete ? Icons.check : Icons.done_all,
                color: !lstore.complete ? Colors.grey : Colors.green,
              ),
              leftButtonFn: () {
                lstore.submit();
                print('left button clicked');
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class BaseBall extends StatefulWidget {
  final bool isActive;
  const BaseBall({Key key, @required this.isActive}) : super(key: key);
  @override
  _BaseBallState createState() => _BaseBallState();
}

class _BaseBallState extends State<BaseBall> {
  double _bigWidth;
  double _smallWidth;

  @override
  void initState() {
    _bigWidth = 40;
    _smallWidth = _bigWidth / 2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   _bigWidth = 50;
        //   // widget.isActive = !widget.isActive;
        // });
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            height: _bigWidth,
            width: _bigWidth,
            decoration: BoxDecoration(
              border: !widget.isActive
                  ? Border.all(width: 0.4, color: Colors.grey)
                  : Border.all(width: 0.8, color: Colors.green),
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                height: widget.isActive ? _smallWidth : 0,
                width: widget.isActive ? _smallWidth : 0,
                decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          !widget.isActive ? Colors.transparent : Colors.green),
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
