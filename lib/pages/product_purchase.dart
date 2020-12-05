import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  ProductPage(
      {Key key,
      @required this.productID,
      this.productName,
      this.amount,
      this.imageURL})
      : super(key: key);
  final String productID;
  final String productName;
  final String amount;
  final String imageURL;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text("Prods"),
        ),
      ),
    );
  }
}
