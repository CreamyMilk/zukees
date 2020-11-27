import 'package:flutter/material.dart';
import 'package:zukes/views/home_tab.dart';
class BaseTabView extends StatefulWidget {

  @override
  _BaseTabViewState createState() => _BaseTabViewState();
}

class _BaseTabViewState extends State<BaseTabView> {
  final _tabs =[
    HomeTab(),
     Center(child:Text("2")),
      Center(child:Text("3")),
       Center(child:Text("4")),
        Center(child:Text("5")),
  ];
  int _activetab;
  @override
  void initState() {

    _activetab=0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var barItem = BottomNavigationBarItem(
        title: Text("🌊"),
        icon: Icon(Icons.sim_card_alert, color: Colors.black));

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activetab,
        onTap: (index) {
          setState(() {
            _activetab = index;
          });
        },
        items: [
          barItem,
          barItem,
          barItem,
          barItem,
          barItem
        ]),
      body:_tabs[_activetab] ,
    );
  }
}
