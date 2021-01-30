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
              SizedBox(height: 10),
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
      onTap: () {
        print("Clicked ListTile");
      },
      tileColor: Color.fromRGBO(252, 252, 252, 1),
      isThreeLine: true,
      title: Row(
        children: [
          Text("Order No"),
          Text("20-2999-34",
              style: TextStyle(
                  fontSize: 14, color: Color.fromRGBO(28, 28, 13, 1))),
        ],
      ),
      subtitle: Row(
        children: [
          Text(
            "Jan 12,2020",
            style: TextStyle(
                fontSize: 12, color: Color.fromRGBO(149, 152, 154, 1)),
          ),
          Text(" Deliverd ",
              style: TextStyle(
                  backgroundColor:
                      10 != 0 ? Colors.lightGreen[200] : Colors.red[200])),
        ],
      ),
      leading: Container(
        color: Colors.yellow,
        width: 2,
        height: 300,
        child: Column(),
      ),
      trailing: Row(
        children: [
          Text("Ksh 7680",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
