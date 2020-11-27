import 'package:flutter/material.dart';
import 'package:zukes/views/home_tab.dart';
import 'package:zukes/views/service_tab.dart';

class BaseTabView extends StatefulWidget {
  @override
  _BaseTabViewState createState() => _BaseTabViewState();
}

class _BaseTabViewState extends State<BaseTabView> {
  final _tabs = [
   
    HomeTab(),
    ServiceTab(),
    //Center(child: Text("9")),
    Center(child: Text("3")),
    Center(child: Text("4")),
    Center(child: Text("5")),
  ];
  int _activetab;
  @override
  void initState() {
    _activetab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var barItem = BottomNavigationBarItem(
        title: Text("🌊"),
        icon: Icon(Icons.sim_card_alert, color: Colors.black));
     var homeItem = BottomNavigationBarItem(
        title: Text("🌊"),
        icon: Icon(Icons.healing, color: Colors.black));
           var serviceItem = BottomNavigationBarItem(
        title: Text("🌊"),
        icon: Icon(Icons.spa, color: Colors.black));
             var shopItem = BottomNavigationBarItem(
        title: Text("🌊"),
        icon: Icon(Icons.shopping_cart, color: Colors.black));
                     var callItem = BottomNavigationBarItem(
        title: Text("🌊"),
        icon: Icon(Icons.contact_phone, color: Colors.black));
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _activetab,
          onTap: (index) {
            setState(() {
              _activetab = index;
            });
          },
          items: [homeItem, serviceItem,barItem, shopItem, callItem]),
      body: _tabs[_activetab],
    );
  }
}
