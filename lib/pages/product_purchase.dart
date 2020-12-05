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
  double slide = 0;
  @override
  void initState() {
    super.initState();
    slide = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Shop LOGO IS HERE"), backgroundColor: Colors.yellow),
      bottomNavigationBar: Card(
        child: Container(
            decoration: BoxDecoration(),
            height: 50,
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    width: 90,
                    height: 50,
                    color: Colors.yellow,
                    child: Row(
                      children: [
                        Text("Search"),
                        Spacer(),
                        Icon(Icons.search),
                      ],
                    )),
                Spacer(),
                Container(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    width: 90,
                    height: 50,
                    child: Row(
                      children: [
                        Text("KSH 0"),
                        Spacer(),
                        Icon(Icons.card_travel),
                      ],
                    )),
              ],
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Bamburi Cement",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("1kg x 20 Packets"),
                Text("KSH 2138/Bale"),
                SizedBox(height: 20),
                Center(
                  child: Image.network(
                    "https://shop.twiga.ke/static/758a50c7e869e88ff7eb52f10026a422/8ea22/0e9f0f9f-2773-4f95-b03d-7fc977a87093.webp",
                    width: 300,
                    height: 300,
                  ),
                ),
                SizedBox(height: 20),
                Text("Enter Quanity in Bales"),
                Slider(
                  value: slide,
                  onChanged: (double value) {
                    setState(() {
                      slide = value;
                    });
                    //print(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
