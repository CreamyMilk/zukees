import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zukes/views/home_tab.dart';
import 'package:zukes/views/manage_tab.dart';
import 'package:zukes/views/service_tab.dart';
import 'package:zukes/views/settings_tab.dart';
import 'package:zukes/views/shop_tab.dart';
import 'package:firebase_core/firebase_core.dart';

class BaseTabView extends StatefulWidget {
  @override
  _BaseTabViewState createState() => _BaseTabViewState();
}

class _BaseTabViewState extends State<BaseTabView> {
  final _tabs = [
    HomeTab(),
    ManageTab(),
    ServiceTab(),
    ShoppingTab(),
    SettingsTab(),
  ];
  int _activetab;
  @override
  void initState() {
    _activetab = 0;
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var text = Text("Home",
    //  style: TextStyle(color: _activetab != 0 ? Colors.black : Colors.blue));
    var homeItem = BottomNavigationBarItem(
        // ignore: deprecated_member_use
        label: "Home",
        icon: Icon(Icons.attach_money, color: Colors.black),
        activeIcon: Icon(Icons.attach_money, color: Colors.blue));
    var serviceItem = BottomNavigationBarItem(
        label: "Manage",
        icon: Icon(Icons.spa, color: Colors.black),
        activeIcon: Icon(
          Icons.spa,
          color: Colors.blue,
        ));
    var krainItem = BottomNavigationBarItem(
        label: "Services",
        icon:
            Hero(tag: "heal", child: Icon(Icons.healing, color: Colors.black)),
        activeIcon: Icon(Icons.healing, color: Colors.blue));
    var shopItem = BottomNavigationBarItem(
        label: "Hardware",
        icon: Icon(Icons.shopping_cart, color: Colors.black),
        activeIcon: Icon(Icons.shopping_cart, color: Colors.blue));
    var callItem = BottomNavigationBarItem(
        label: "Contacts",
        icon: Icon(Icons.contact_phone, color: Colors.black),
        activeIcon: Icon(Icons.contact_phone, color: Colors.blue));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            selectedFontSize: 12,
            unselectedFontSize: 10,
            iconSize: 20,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            type: BottomNavigationBarType.fixed,
            currentIndex: _activetab,
            onTap: (index) {
              setState(() {
                _activetab = index;
              });
            },
            items: [homeItem, serviceItem, krainItem, shopItem, callItem]),
        body: _tabs[_activetab],
      ),
    );
  }
}
