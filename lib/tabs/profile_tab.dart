import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zukes/widgets/getNewAPIdata.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _version = "0.0.5 Alpha";
    //final MediaQueryData d = MediaQuery.of(context);
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: getLatestTrans,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80,
            pinned: true,
            floating: false,
            centerTitle: true,
            title: Text(
              "Profile /Settings",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                ValueListenableBuilder(
                    valueListenable: Hive.box('user').listenable(),
                    builder: (BuildContext context, box, Widget child) {
                      return ListTile(
                        visualDensity:
                            VisualDensity(horizontal: 1.0, vertical: 2.0),
                        title: Text("${box.get("name")}"),
                        subtitle: Text("ST.FRANCIS"),
                        trailing: Icon(Icons.qr_code),
                        leading: CircleAvatar(
                            minRadius: 30,
                            backgroundColor: Color(0xfffe8fcfa),
                            child: Text("ON")),
                      );
                    }),
                SizedBox(height: 20),
                Divider(),
                Text("GENERAL",
                    style: TextStyle(
                        color: Colors.grey, letterSpacing: 2, fontSize: 20)),
                ListTile(
                  title: Text("Account"),
                  subtitle: Text("Privacy , Notifications"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  leading: IconButton(
                    icon: Icon(Icons.vpn_key),
                    onPressed: () {},
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text("Shopping"),
                  subtitle: Text(
                    "Past Orders,Receipts",
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  leading: IconButton(
                    icon: Icon(Icons.receipt_long),
                    onPressed: () {},
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text("Help"),
                  subtitle: Text(
                    "Contacts,Faqs",
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  leading: IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () {},
                  ),
                ),
                Divider(),
                Text("FEEDBACK",
                    style: TextStyle(
                        color: Colors.grey, letterSpacing: 2, fontSize: 20)),
                ListTile(
                  title: Text("Report a bug"),
                  subtitle: Text(
                    "Contacts,Report Issues",
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(Icons.connect_without_contact),
                  leading: IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () async {
                      final url =
                          "https://wa.me/254798979797?text=My%20Landloard%20app%20is%20having%20some%20issues.";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text("Send feedback"),
                  trailing: Icon(Icons.send),
                  leading: IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () async {
                      final url =
                          "https://wa.me/254798979797?text=My%20Landloard%20app%20is%20having%20some%20issues.";
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: OutlineButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.red[50],
                      highlightedBorderColor: Colors.red[50],
                      focusColor: Colors.red[50],
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs
                            .setString("user_token", "Logged Out User")
                            .then((bool success) {
                          if (success) {
                            print("Successfully Logged out.");
                            Navigator.of(context).pushReplacementNamed('/');
                          } else {
                            //Show that storage
                          }
                        });
                      },
                      child: Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.red),
                      )),
                ),
                SizedBox(height: 20),
                Text(
                  "App Version: $_version",
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
