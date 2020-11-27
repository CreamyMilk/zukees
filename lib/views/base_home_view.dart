import 'package:flutter/material.dart';
import 'package:zukes/widgets/user_profile_card.dart';
import 'package:zukes/widgets/monthly_trans.dart';


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
        child: SingleChildScrollView(
                  child: Container(
            child: Column(
              children: [
                Text("Hello from zukes 👋"),
                UserProfileCard(),
                LegendDefault(),
              ],
            ),
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
    _activetab = 1;
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
