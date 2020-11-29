import 'package:flutter/material.dart';

class ServiceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
                  child: Column(mainAxisSize:MainAxisSize.min,children: [
                    Text("Featured Categories",  style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.purple),),
            ItemCategoryGrid(),
          ]),
        ));
  }
}

class ItemCategoryGrid extends StatefulWidget {
  @override
  _ItemCategoryGridState createState() => _ItemCategoryGridState();
}

class _ItemCategoryGridState extends State<ItemCategoryGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height:500,width:500,
          child: GridView.count(
                  crossAxisCount: 2,
                  children:[ Itemtile(),],
      ),
    );
  }
}

class Itemtile extends StatelessWidget {
  const Itemtile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
          footer:Card(child: Text("Apply for 🤖 Automated KRA File Taxingsdfsdfsdfsdf\n\n")),
          child:Image.asset("assets/kraicon.png"),

        );
  }
}