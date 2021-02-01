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
    final notif = prefs.getBool('Notifications') ?? true;
    final sms = prefs.getBool('SMS') ?? false;
    accepted = sms;
    newterm = notif;
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
                        subtitle: Text("When a Tenant has complested payment"),
                        value: newterm,
                        onChanged: (newValue) async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool("Notifications", newValue);
                          setState(() {
                            newterm = newValue;
                          });
                        }),
                    SwitchListTile(
                        title: Text("Receive SMS "),
                        subtitle:
                            Text("On product delivery has completed payment"),
                        value: accepted,
                        onChanged: (newValue) async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool("SMS", newValue);
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
