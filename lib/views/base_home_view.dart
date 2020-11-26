import 'package:flutter/material.dart';

class BaseHomeView extends StatelessWidget {
  const BaseHomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var barItem = BottomNavigationBarItem(
        title: Text("🌊"),
        icon: Icon(Icons.sim_card_alert, color: Colors.black));
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarBase(barItem: barItem),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text("Hello from zukes 👋"),
              Card(
                child: Container(
                    color: Colors.teal,
                    height: 100,
                    width: 1000,
                    child: Text("Zukes Card🗿")),
              ),
              Card(
                  child: Container(
                      color: Colors.lightBlue,
                      height: 300,
                      width: 1000,
                      child: Text("📈Zukes Charts go here boys")))
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigationBarBase extends StatefulWidget {
  const BottomNavigationBarBase({
    Key key,
    @required this.barItem,
  }) : super(key: key);

  final BottomNavigationBarItem barItem;

  @override
  _BottomNavigationBarBaseState createState() =>
      _BottomNavigationBarBaseState();
}

class _BottomNavigationBarBaseState extends State<BottomNavigationBarBase> {
  int _activetab;
  @override
  void initState() {
    _activetab = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: _activetab,
        onTap: (index) {
          setState(() {
            _activetab = index;
          });
          ;
        },
        items: [
          widget.barItem,
          widget.barItem,
          widget.barItem,
          widget.barItem,
          widget.barItem
        ]);
  }
}
