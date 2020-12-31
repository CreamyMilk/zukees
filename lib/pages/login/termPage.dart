import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
            expandedHeight: 150,
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
          SliverFillRemaining(
              child: WebView(
            initialUrl:
                'https://docs.python.org/release/1.4/ref/ref2.html#HDR1',
          ))
        ],
      ),
    );
  }
}
