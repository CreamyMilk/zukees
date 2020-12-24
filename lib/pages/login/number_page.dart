import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zukes/providers/login_data.dart';
import 'package:zukes/widgets/onScreenPad.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lstore = Provider.of<LoginData>(context);
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(children: [Icon(Icons.spa, color: Colors.grey)]),
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
          Text(lstore.pin),
          Row(children: [
            // lstore.buttonStates.forEach((k) => Text('$k')),
            Spacer(),
            BaseBall(),
            BaseBall(),
            BaseBall(),
            BaseBall(),
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
  @override
  _BaseBallState createState() => _BaseBallState();
}

class _BaseBallState extends State<BaseBall> {
  double _bigWidth;
  double _smallWidth;
  bool _active;
  @override
  void initState() {
    _bigWidth = 50;
    _smallWidth = 0;
    _active = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _bigWidth = 50;
          _smallWidth = !_active ? 25 : 0;
          _active = !_active;
        });
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            height: _bigWidth,
            width: _bigWidth,
            decoration: BoxDecoration(
              border: !_active
                  ? Border.all(width: 0.4, color: Colors.grey)
                  : Border.all(width: 0.8, color: Colors.green),
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 400),
                height: _smallWidth,
                width: _smallWidth,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: !_active ? Colors.transparent : Colors.green),
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
