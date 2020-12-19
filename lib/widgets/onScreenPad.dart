import 'package:flutter/material.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  final Color textColor;
  final Icon rightIcon;
  final Function() rightButtonFn;
  final Icon leftIcon;
  final Function() leftButtonFn;
  final KeyboardTapCallback onKeyboardTap;
  final MainAxisAlignment mainAxisAlignment;

  NumericKeyboard(
      {Key key,
      @required this.onKeyboardTap,
      this.textColor = Colors.black,
      this.rightButtonFn,
      this.rightIcon,
      this.leftButtonFn,
      this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only( top: 20),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton(context,'1'),
              _calcButton(context,'2'),
              _calcButton(context,'3'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton(context,'4'),
              _calcButton(context,'5'),
              _calcButton(context,'6'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton(context,'7'),
              _calcButton(context,'8'),
              _calcButton(context,'9'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.leftButtonFn,
                  child: Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: widget.leftIcon)),
              _calcButton(context,'0'),
              InkWell(
                  borderRadius: BorderRadius.circular(45),
                  onTap: widget.rightButtonFn,
                  child: Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      child: widget.rightIcon))
            ],
          ),
        ],
      ),
    );
  }

  Widget _calcButton(BuildContext context,String value) {
    return InkWell(
        borderRadius: BorderRadius.circular(45),
        onTap: () {
          widget.onKeyboardTap(value);
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width *0.2,
          height: 70,
          child: Text(
            value,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                color: widget.textColor),
          ),
        ));
  }
}
