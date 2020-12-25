import 'package:flutter/material.dart';

class TermsAndConditonsWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 180,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Center(
                  child: Text(
                "TERMS & CONDITIONS",
                style: TextStyle(color: Colors.black),
              )),
              background: Container(color: Colors.white),
            ),
          ),
          SliverFillRemaining(child: Center(child: Text("Add web view here")))
        ],
      ),
    );
  }
}
