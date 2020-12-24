import 'package:flutter/material.dart';
import 'package:zukes/widgets/getNewAPIdata.dart';
import 'package:zukes/widgets/user_profile_card.dart';
import 'package:zukes/widgets/graph_trans.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final MediaQueryData d = MediaQuery.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: getLatestTrans,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Hello from zukes 👋"),
                UserProfileCard(),
                CoolGraph(
                    firestoreKey: "building8"), //Add Hive to proivde this value
              ],
            ),
          ),
        ),
      ),
    );
  }
}
