import 'package:flutter/material.dart';
import 'package:zukes/widgets/getNewAPIdata.dart';

import 'package:zukes/widgets/graph_trans.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final MediaQueryData d = MediaQuery.of(context);
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: getLatestTrans,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Terms and Conditions"),
            backgroundColor: Colors.white,
            elevation: 0.0,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Text("jk1@gmail.com👋"),
                Text("Jothan Kinyua"),
                SizedBox(height: 10),
                Card(
                  child: Row(children: [
                    Expanded(
                        flex: 10,
                        child: Text("Get a daily quite\n of all expnses")),
                    Expanded(flex: 1, child: Icon(Icons.present_to_all))
                  ]),
                ),
                CoolGraph(firestoreKey: "building8"),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
