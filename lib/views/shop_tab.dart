import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
class ShoppingTab extends StatelessWidget {
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
  List<dynamic> allcategories = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      height:500,width:500,
          child: GridView.count(
            padding:EdgeInsets.all(8.0),
            mainAxisSpacing:6,
            crossAxisSpacing: 6,
                  crossAxisCount: 2,
                  children:[ Itemtile(prodname:"Featured Products\n\n",imageUrl:"https://shop.twiga.ke/static/f5457552125a73157ed63cd2e498031b/8ea22/1c70ab84-5d59-455b-9c64-fc9ebc4c0f421589493611.211105.webp"),
                  Itemtile(prodname:"Cement \n\n",imageUrl:"https://shop.twiga.ke/static/758a50c7e869e88ff7eb52f10026a422/8ea22/0e9f0f9f-2773-4f95-b03d-7fc977a87093.webp")],
      ),
    );
  }
}

class Itemtile extends StatelessWidget {
  Itemtile({this.prodname,this.imageUrl});
  final String prodname;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return  GridTile(
            footer:InkWell(
      onTap:(){
        print(prodname);
      },
          child: Container(color:Colors.white,child: Text(prodname))),
            child:InkWell(onTap:(){print(prodname);},child: BlurHash(hash:"""LXP~\$byZ?aM|_4x]R%Vs%OX3RQt6""",image:imageUrl)),
          );
    
  }
}