import 'package:flutter/material.dart';

class TermsAndConditonsWebView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            backgroundColor: Colors.white,
            expandedHeight: 180,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "TERMS & CONDITIONS",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
              ),
              background: Container(color: Colors.white),
            ),
          ),
          SliverFillRemaining(child: Center(child: Text("Add web view here")))
        ],
      ),
    );
  }
}
