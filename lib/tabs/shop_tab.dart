import 'package:flutter/material.dart';

import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:zukes/pages/store/getShopData.dart';
import 'package:zukes/widgets/getNewAPIdata.dart';

class ShoppingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(
          "Featured Categories",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.purple),
        ),
        RefreshIndicator(onRefresh: getLatestTrans, child: ItemCategoryGrid()),
      ]),
    ));
  }
}

class ItemCategoryGrid extends StatefulWidget {
  @override
  _ItemCategoryGridState createState() => _ItemCategoryGridState();
}

class _ItemCategoryGridState extends State<ItemCategoryGrid> {
  List<dynamic> allcategories = [
    Itemtile(
      prodname: "Featured Products\n\n",
      imageUrl:
          "https://shop.twiga.ke/static/f5457552125a73157ed63cd2e498031b/8ea22/1c70ab84-5d59-455b-9c64-fc9ebc4c0f421589493611.211105.webp",
      categoryID: 9000,
    ),
    Itemtile(
      prodname: "Cement \n\n",
      imageUrl:
          "https://shop.twiga.ke/static/758a50c7e869e88ff7eb52f10026a422/8ea22/0e9f0f9f-2773-4f95-b03d-7fc977a87093.webp",
      categoryID: 5000,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: MediaQuery.of(context).size.width,
      child: CategoriesFutureBuilder(),
    );
  }
}

class CategoriesFutureBuilder extends StatelessWidget {
  const CategoriesFutureBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllCategories(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("${snapshot.data}");
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 6, crossAxisCount: 2, crossAxisSpacing: 6),
                padding: EdgeInsets.all(8.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Itemtile(
                    prodname: snapshot.data[index]["category_name"],
                    imageUrl: snapshot.data[index]["category_image"],
                    categoryID: snapshot.data[index]["category_id"],
                  );
                });
          } else {
            //Make UI to act as place holder first
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }
        });
  }
}

class Itemtile extends StatelessWidget {
  Itemtile(
      {@required this.prodname,
      @required this.imageUrl,
      @required this.categoryID});
  final String prodname;
  final String imageUrl;
  final int categoryID;
  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: InkWell(
          onTap: () {
            print(prodname);
            Navigator.of(context).pushNamed('/products', arguments: categoryID);
          },
          child: Container(
              color: Color(0xffff2f2f2),
              child: Center(
                  child: Text(
                prodname,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              )))),
      child: InkWell(
          onTap: () {
            print(prodname);
          },
          child: BlurHash(
              color: Colors.white,
              hash: """LXP~\$byZ?aM|_4x]R%Vs%OX3RQt6""",
              image: imageUrl)),
    );
  }
}
