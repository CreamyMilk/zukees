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
            
            backgroundColor: Colors.white70,
            flexibleSpace: FlexibleSpaceBar(centerTitle: true, title: Text(
              "Profile /Settings",
              style: TextStyle(fontWeight:FontWeight.w500,color: Colors.black),
            ),),
            expandedHeight: 110,
            pinned: true,
            floating: true,
            
           
            
            elevation: 0.5,
          ),
          SliverFillRemaining(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: ValueListenableBuilder(
                      valueListenable: Hive.box('user').listenable(),
                      builder: (BuildContext context, box, Widget child) {
                        return Text("${box.get("name")}");
                      }),
                  subtitle: Text("ST.FRANCIS"),
                  trailing: Icon(Icons.qr_code),
                  leading: CircleAvatar(
                      minRadius: 3,
                      maxRadius: 30,
                      backgroundColor: Color(0xfffe8fcfa),
                      child: Text("ON")),
                ),
                SizedBox(height: 10),
                Text("GENERAL",
                    style: TextStyle(
                        color: Colors.grey, letterSpacing: 2, fontSize: 15)),
                ListTile(
                   leading:IconButton( onPressed:(){},icon:Icon(Icons.person_outline,size:30,color:Colors.black)),
                  title: Text("🔑 Account"),
                  subtitle: Text("Privacy , Notifications"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 10),
               
                ),
                Divider(),
                ListTile(
                  title: Text("🛍 Shopping"),
                  subtitle: Text(
                    "Past Orders ,Receipts",
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 10),
                  leading:IconButton( onPressed:(){},icon:Icon(Icons.receipt_long,size:30,color:Colors.black87)),
                ),
                Divider(),
                ListTile(
                  dense:true,
        
                  onTap: (){
                    print("oooo");
                  },
                  title: Text("📞 Help"),
                  subtitle: Text(
                    "Contacts ,Faqs",
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 10),
                  leading: IconButton(
                    icon: Icon(Icons.help_outline,size:30,color:Colors.black87),
                    onPressed: () {},
                  ),
                ),
                Divider(),
                SizedBox(height: 10),
                Text("FEEDBACK",
                    style: TextStyle(
                        color: Colors.grey, letterSpacing: 2, fontSize: 15)),
                SizedBox(height: 2),
                ListTile(
                  title: Text("Report a bug"),
                  leading: IconButton(
                      icon: Icon(Icons.connect_without_contact,size:25,color:Colors.black87),
                      onPressed: () {}),
                ),
                Divider(),
                ListTile(
                  dense: true,
                  title: Text("Send feedback"),
                  leading: IconButton(
                    icon: Icon(Icons.send,size:25,color:Colors.black87),
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
