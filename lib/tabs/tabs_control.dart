import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zukes/pages/store/storefromnt.dart';
import 'package:zukes/tabs/home_tab.dart';
import 'package:zukes/tabs/manage_tab.dart';
import 'package:zukes/tabs/service_tab.dart';
import 'package:zukes/tabs/profile_tab.dart';
import 'package:animations/animations.dart';
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
    StoreFront(),
    ProfileTab(),
  ];
  int _activetab;
  bool _reverse;
  SharedAxisTransitionType _transitionType =
      SharedAxisTransitionType.horizontal;
  @override
  void initState() {
    _activetab = 0;
    _reverse = false;
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
        label: "Store",
        icon: Icon(Icons.shopping_cart, color: Colors.black),
        activeIcon: Icon(Icons.shopping_cart, color: Colors.blue));
    var callItem = BottomNavigationBarItem(
        label: "Profile",
        icon: Icon(Icons.contact_phone, color: Colors.black),
        activeIcon: Icon(Icons.contact_phone, color: Colors.blue));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: _activetab == 3
              ? AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  actions: [
                    Container(
                        color: Colors.amber,
                        child: Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.card_travel),
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/cart');
                                }),
                            Text("3")
                          ],
                        )),
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.read_more, color: Colors.black),
                    onPressed: () {
                      print("Show Drawer");
                    },
                  ),
                )
              : null,
          bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 12,
              unselectedFontSize: 10,
              iconSize: 20,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.blue,
              type: BottomNavigationBarType.fixed,
              currentIndex: _activetab,
              onTap: (index) {
                if (index < _activetab) {
                  setState(() {
                    _reverse = false;
                    _activetab = index;
                  });
                } else {
                  setState(() {
                    _reverse = true;
                    _activetab = index;
                  });
                }
              },
              items: [homeItem, serviceItem, krainItem, shopItem, callItem]),
          body: SafeArea(
            child: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 600),
                reverse: _reverse,
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                ) {
                  return SharedAxisTransition(
                    child: child,
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: _transitionType,
                  );
                },
                child: _tabs[_activetab]),
          ),
        ),
      ),
    );
  }
}
