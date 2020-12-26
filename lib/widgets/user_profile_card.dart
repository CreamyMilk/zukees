import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Column(children: <Widget>[
          SizedBox(
            height: 150.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    'assets/matdesign_4.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 130.0,
                  left: 16.0,
                  right: 16.0,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: ValueListenableBuilder(
                        valueListenable: Hive.box('user').listenable(),
                        builder: (BuildContext context, box, Widget child) {
                          return Text(
                            box.get("name"),
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(color: Colors.white),
                          );
                        }),
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
                child: const Text('STATS'),
              ),
              // FlatButton(
              //   onPressed: () {},
              //   child: const Text('EXPLORE'),
              // ),
            ],
          ),
        ]));
  }
}
