import 'package:flutter/material.dart';

class CoolGridValue extends StatefulWidget {
  @override
  _CoolGridValueState createState() => _CoolGridValueState();
}

class _CoolGridValueState extends State<CoolGridValue> {
  double _cwidth;
  @override
  void initState() {
    _cwidth = 90;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("pressed");
        setState(() {
          _cwidth = _cwidth + 45;
        });
      },
      child: AnimatedContainer(
          duration: Duration(seconds: 1), height: _cwidth, color: Colors.green),
    );
  }
}
 

class KraCardSample extends StatelessWidget {
  const KraCardSample({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Column(children: <Widget>[
          SizedBox(
            height: 90.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    'assets/matdesign_4.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 45.0,
                  left: 16.0,
                  right: 16.0,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Auctioner sample Card',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: const Text('📞 Contact Auctioner'),
              ),

            ],
          ),
        ]));
  }
}