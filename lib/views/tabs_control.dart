import 'package:flutter/material.dart';
import 'package:zukes/views/home_tab.dart';
import 'package:zukes/views/manage_tab.dart';
import 'package:zukes/views/service_tab.dart';

class BaseTabView extends StatefulWidget {
  @override
  _BaseTabViewState createState() => _BaseTabViewState();
}

class _BaseTabViewState extends State<BaseTabView> {
  final _tabs = [
    HomeTab(),
    ManageTab(),                      
    ServiceTab(),
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
    var homeItem = BottomNavigationBarItem(
        title: Text("Home",
            style:
                TextStyle(color: _activetab != 0 ? Colors.black : Colors.blue)),
        icon: Icon(Icons.attach_money, color: Colors.black),
        activeIcon: Icon(Icons.attach_money, color: Colors.blue));
    var serviceItem = BottomNavigationBarItem(
        title: Text(
          "Manage",
          style: TextStyle(color: _activetab != 1 ? Colors.black : Colors.blue),
        ),
        icon: Icon(Icons.spa, color: Colors.black),
        activeIcon: Icon(Icons.spa, color: Colors.blue));
    var krainItem = BottomNavigationBarItem(
        title: Text("Service",
            style:
                TextStyle(color: _activetab != 2 ? Colors.black : Colors.blue)),
        icon: Icon(Icons.healing, color: Colors.black),
        activeIcon: Icon(Icons.healing, color: Colors.blue));
    var shopItem = BottomNavigationBarItem(
        title: Text("Hardware",
            style:
                TextStyle(color: _activetab != 3 ? Colors.black : Colors.blue)),
        icon: Icon(Icons.shopping_cart, color: Colors.black),
        activeIcon: Icon(Icons.shopping_cart, color: Colors.blue));
    var callItem = BottomNavigationBarItem(
        title: Text("Contacts",
            style:
                TextStyle(color: _activetab != 4 ? Colors.black : Colors.blue)),
        icon: Icon(Icons.contact_phone, color: Colors.black),
        activeIcon: Icon(Icons.contact_phone, color: Colors.blue));

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _activetab,
          onTap: (index) {
            setState(() {
              _activetab = index;
            });
          },
          items: [homeItem, serviceItem, krainItem, shopItem, callItem]),
      body: _tabs[_activetab],
    );
  }
}
