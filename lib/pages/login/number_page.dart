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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Add animation to turn to scratch card then submit to verify
          Text(lstore.number),
          SizedBox(
            height: 50,
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
    );
  }
}
