import 'package:flutter/material.dart';

class PastShopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Past Purchases"),
      ),
      body: SafeArea(
        child: Column(
          children: [Text("Orders should be placed here ")],
        ),
      ),
    );
  }
}
