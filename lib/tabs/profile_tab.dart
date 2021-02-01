import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zukes/widgets/getNewAPIdata.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _version = "0.1.1 Alpha";
    //final MediaQueryData d = MediaQuery.of(context);
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: getLatestTrans,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Profile /Settings",
                style:
                    TextStyle(fontWeight: FontWeight.w300, color: Colors.black),
              ),
            ),
            expandedHeight: 60,
            pinned: false,
            elevation: 0.5,
          ),
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  onTap: () {
                    print("update page click hanlder");
                  },
                  title: ValueListenableBuilder(
                      valueListenable: Hive.box('user').listenable(),
                      builder: (BuildContext context, box, Widget child) {
                        return Text("${box.get("name")}");
                      }),
                  subtitle: Text("ST.FRANCIS"),
                  trailing: Icon(Icons.qr_code),
                  leading: Hero(
                    tag: "profilepic",
                    child: CircleAvatar(
                        minRadius: 3,
                        maxRadius: 20,
                        backgroundColor: Color(0xfffe8fcfa),
                        child: Text("ON")),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("GENERAL",
                      style: TextStyle(
                          color: Colors.grey, letterSpacing: 2, fontSize: 15)),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed("/buildingprofile");
                  },
                  dense: true,
                  leading: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.person_outline,
                          size: 25, color: Colors.black)),
                  title: Text("🔑 Account"),
                  subtitle: Text("Privacy , Notifications"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 10),
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    Navigator.of(context).pushNamed("/pastshoping");
                  },
                  title: Text("🛍 Shopping"),
                  subtitle: Text(
                    "Past Orders , Deliveries",
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 10),
                  leading: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.receipt_long,
                          size: 25, color: Colors.black87)),
                ),
                ListTile(
                  dense: true,
                  onTap: () async {
                    final url = "tel:+254714164318";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  title: Text("📞 Help"),
                  subtitle: Text(
                    "Contacts ,Faqs",
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 10),
                  leading: IconButton(
                    icon: Icon(Icons.help_outline,
                        size: 25, color: Colors.black87),
                    onPressed: () {},
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("FEEDBACK",
                      style: TextStyle(
                          color: Colors.grey, letterSpacing: 2, fontSize: 15)),
                ),
                SizedBox(height: 2),
                ListTile(
                  onTap: () async {
                    final url =
                        "https://wa.me/254714164318?text=My%20Landloard%20app%20is%20having%20some%20issues.";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  dense: true,
                  title: Text("Report a bug"),
                  leading: IconButton(
                      icon: Icon(Icons.connect_without_contact,
                          size: 23, color: Colors.black87),
                      onPressed: () {}),
                ),
                ListTile(
                  onTap: () async {
                    final url =
                        "https://wa.me/254714164318?text=The%20App%20is%20quite%20nice.%20I%20would%20suggest%20you%20add%20feature ....";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  dense: true,
                  title: Text("Send feedback"),
                  leading: IconButton(
                      icon: Icon(Icons.send, size: 23, color: Colors.black87),
                      onPressed: () {}),
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
