import 'package:flutter/material.dart';

class ServiceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
                  child: Column(mainAxisSize:MainAxisSize.min,children: [
            KraCardSample(),
            KraGrid(),
          ]),
        ));
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
            height: 180.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    'assets/kraicon.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 100.0,
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

class KraGrid extends StatefulWidget {
  @override
  _KraGridState createState() => _KraGridState();
}

class _KraGridState extends State<KraGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:500,width:500,
          child: GridView.count(
                  crossAxisCount: 2,
                  children:[ GridTile(
          footer:Card(child: Text("Apply for 🤖 Automated KRA File Taxingsdfsdfsdfsdf\n\n")),
          child:Image.asset("assets/kraicon.png")

          
        ), GridTile(
          footer:Card(child: Text("Apply for 🤖 Random Service KRA File Taxingsdfsdfsdfsdf\n\n")),
          child:Image.asset("assets/kraicon.png")
          
        ),
        Card(child:Stack(
          children: [
            Image.asset("assets/kraicon.jpg"),
            ButtonBar(
               alignment: MainAxisAlignment.end,
              children: [
              
              Text("Active ✅"),
              
            ],)
          ],
        ))],
      ),
    );
  }
}