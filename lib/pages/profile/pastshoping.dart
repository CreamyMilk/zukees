import 'package:flutter/material.dart';

class PastShopping extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Past Purchases"),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              SizedBox(height: 5),
              OrderTile(),
              OrderTile(),
              OrderTile(),
              OrderTile(),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 20,
        height: 50,
      ),
      onTap: () {
        print("Clicked ListTile");
      },
      tileColor: Color.fromRGBO(252, 252, 252, 1),
      isThreeLine: true,
      title: RichText(
          text: TextSpan(
        children: [
          TextSpan(
              text: "Order No :\n",
              style: TextStyle(fontSize: 7, color: Colors.black)),
          TextSpan(
              text: "20-2999-34",
              style: TextStyle(
                  fontSize: 14, color: Color.fromRGBO(28, 28, 13, 1))),
        ],
      )),
      subtitle: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: "Jan 12,2020   ",
            style: TextStyle(
                fontSize: 10, color: Color.fromRGBO(149, 152, 154, 1)),
          ),
          TextSpan(
              text: " Deliverd ",
              style: TextStyle(
                  fontSize: 10,
                  backgroundColor:
                      10 != 0 ? Colors.lightGreen[200] : Colors.red[200])),
        ]),
      ),
      trailing: Text("Ksh 7680",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
    );
  }
}
