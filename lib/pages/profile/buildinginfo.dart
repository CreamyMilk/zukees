import 'package:flutter/material.dart';

class BuildingProfilePage extends StatelessWidget {
  const BuildingProfilePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ST FRANCIS"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "profilepic",
              child: CircleAvatar(
                  minRadius: 10,
                  maxRadius: 55,
                  backgroundColor: Color(0xfffe8fcfa),
                  child: Text("ON")),
            ),
            Text("Minor Descriptions")
          ],
        ),
      ),
    );
  }
}
