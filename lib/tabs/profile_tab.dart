import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zukes/widgets/getNewAPIdata.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _version = "0.1 Beta";
    //final MediaQueryData d = MediaQuery.of(context);
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: getLatestTrans,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            floating: false,
            centerTitle: true,
            title: Text(
              "Profile ",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Text("jk1@gmail.com👋"),
                Text("Jothan Kinyua"),
                Spacer(),
                OutlineButton(
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
                SizedBox(height: 10),
                Text(
                  "App version: $_version",
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
