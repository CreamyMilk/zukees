import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class BuildingProfilePage extends StatefulWidget {
  const BuildingProfilePage({Key key}) : super(key: key);

  @override
  _BuildingProfilePageState createState() => _BuildingProfilePageState();
}

class _BuildingProfilePageState extends State<BuildingProfilePage> {
  bool accepted;
  bool newterm;
  @override
  void initState() async {
    super.initState();
    final prefs = await SharedPreferences.getInstance();
    final notif = prefs.getBool('Notifications');
    final sms = prefs.getBool('SMS');
    accepted = notif ?? true;
    newterm = sms ?? false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ST FRANCIS"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: "profilepic",
                child: CircleAvatar(
                    minRadius: 10,
                    maxRadius: 55,
                    backgroundColor: Color(0xfffe8fcfa),
                    child: Text("ON")),
              ),
              Expanded(
                child: ListView(
                  children: [
                    SwitchListTile(
                        title: Text("Receive Notifications "),
                        subtitle: Text("When a Tenant has completed payment"),
                        value: newterm,
                        onChanged: (newValue) {
                          setState(() {
                            newterm = newValue;
                          });
                        }),
                    SwitchListTile(
                        title: Text("Receive Notifications "),
                        subtitle: Text("When a Tenant has completed payment"),
                        value: accepted,
                        onChanged: (newValue) {
                          setState(() {
                            accepted = newValue;
                          });
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
