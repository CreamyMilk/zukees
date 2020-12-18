import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:zukes/widgets/getNewAPIdata.dart';

String getAppversion() {
  //String appName = packageInfo.appName;
  String rs;
  PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
    //String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    rs = packageName + "/ v:" + version + "/ b:" + buildNumber;
  });
  print("-------------<$rs");
  return rs;
}

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _version = "sdsdsd";

    getAppversion();
    //final MediaQueryData d = MediaQuery.of(context);
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: getLatestTrans,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            title: Text(
              "Contacts Page",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Text("jk1@gmail.com👋"),
                Text("Jothan Kinyua"),
                SizedBox(height: 400),
                OutlineButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.red[50],
                    highlightedBorderColor: Colors.red[50],
                    focusColor: Colors.red[50],
                    onPressed: () {
                      print("Signing out");
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
