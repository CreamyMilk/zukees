import 'package:flutter/material.dart';
import 'package:zukes/widgets/user_profile_card.dart';
import 'package:zukes/widgets/monthly_trans.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
      );
  }
}