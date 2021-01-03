import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:zukes/tabs/shop_tab.dart';

class StoreFront extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            ProductSearchSection(),
            ProductsCarossel(),
          ],
        ),
      ),
    );
  }
}

class ProductSearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.31,
      padding: EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Our \n",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 30.0)),
                TextSpan(
                    text: "Products",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 25.0)),
              ]),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Required";
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      counterText: "",
                      labelText: 'Search here',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Text("Categories",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            CategoriesListNew(),
          ]),
    );
  }
}

class StoreAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: [
        IconButton(
            icon: Icon(
              Icons.card_travel_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/cartPage');
            })
      ],
      leading: IconButton(
        icon: Icon(Icons.read_more, color: Colors.black),
        onPressed: () {
          print("Show Drawer");
        },
      ),
    );
  }
}

class CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // CategoryTile(),
        // CategoryTile(),
        // CategoryTile(),
        // // SizedBox(
        //   width: 10,
        // ),
        // PaymentTile(),
      ],
    );
  }
}

class CategoriesListNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllCategories(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("${snapshot.data}");
            return Container(
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(8.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      prodname: snapshot.data[index]["category_name"],
                      imageUrl: snapshot.data[index]["category_image"],
                      categoryID: snapshot.data[index]["category_id"],
                    );
                  }),
            );
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

class CategoryTile extends StatefulWidget {
  final String prodname;
  final String imageUrl;
  final int categoryID;
  CategoryTile(
      {@required this.prodname,
      @required this.imageUrl,
      @required this.categoryID});
  @override
  _CategoryTileState createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool _enabled = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: MaterialButton(
            minWidth: 20,
            height: 20, // CategoryTile(),
            // CategoryTile(),
            // CategoryTile(),
            // // SizedBox(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: _enabled
                    ? BorderSide(color: Colors.orange)
                    : BorderSide(color: Colors.grey)),
            elevation: 3.0,
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            onPressed: () {
              setState(() {
                _enabled = !_enabled;
              });
            },
            child: ColorFiltered(
              colorFilter: _enabled
                  ? ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.multiply,
                    )
                  : ColorFilter.matrix(<double>[
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0.2126,
                      0.7152,
                      0.0722,
                      0,
                      0,
                      0,
                      0,
                      0,
                      1,
                      0,
                    ]),
              child: Container(
                width: 20,
                height: 20,
                child: Image.network(
                  'https://favicon-generator.org/favicon-generator/htdocs/favicons/2014-11-30/10ef4f0ab17f09ae2073866695eae3f7.ico',
                  fit: BoxFit.scaleDown,
                  width: 10,
                  height: 10,
                ),
              ),
            ),
          ),
        ),
        Text("Cement",
            style: TextStyle(color: _enabled ? Colors.orange : Colors.grey)),
      ],
    );
  }
}

class ProductsCarossel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Products",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w400)),
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            child: ListView(
              padding: EdgeInsets.all(4.0),
              scrollDirection: Axis.horizontal,
              children: [
                ProductCard(
                  amount: 4000,
                  heros: 2,
                  prodname: "Cool Name",
                  imageUrl:
                      "https://shop.twiga.ke/static/ac2803e0375850278fe923c52490784b/8ea22/eddacd9e-8170-4e1d-8cad-0a550d5c2a461604472076.52438.webp",
                  productID: 1,
                  packingType: "Cool packing config",
                ),
                ProductCard(
                  amount: 34,
                  heros: 5,
                  prodname: "Cool Name",
                  imageUrl:
                      "https://shop.twiga.ke/static/ac2803e0375850278fe923c52490784b/8ea22/eddacd9e-8170-4e1d-8cad-0a550d5c2a461604472076.52438.webp",
                  productID: 1,
                  packingType: "Cool packing config",
                ),
                ProductCard(
                  amount: 9903,
                  heros: 6,
                  prodname: "Cool Name",
                  imageUrl:
                      "https://shop.twiga.ke/static/ac2803e0375850278fe923c52490784b/8ea22/eddacd9e-8170-4e1d-8cad-0a550d5c2a461604472076.52438.webp",
                  productID: 1,
                  packingType: "Cool packing config",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key key,
      @required this.prodname,
      @required this.packingType,
      @required this.imageUrl,
      @required this.amount,
      @required this.productID,
      @required this.heros})
      : super(key: key);
  final String prodname;
  final String imageUrl;
  final int amount;
  final int productID;
  final String packingType;
  final int heros;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        width: 210,
        color: Colors.transparent,
        child: Card(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  height: 190,
                  width: 200,
                  color: Colors.transparent,
                  child: BlurHash(
                      color: Colors.transparent,
                      hash: """LXP~\$byZ?aM|_4x]R%Vs%OX3RQt6""",
                      image: imageUrl)),
              SizedBox(height: 3),
              Text("\$ $amount",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24)),
              SizedBox(height: 3),
              Text(prodname,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15)),
              SizedBox(height: 13),
              Text(packingType, style: TextStyle(color: Colors.grey)),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  Icon(Icons.add_circle_outline),
                ],
              ),
              // Hero(
              //   tag: "button $productID",
              //   child: MaterialButton(
              //     color: Colors.red,
              //     onPressed: () {
              //       Navigator.of(context).pushNamed("/product", arguments: productID);
              //     },
              //     child: Text("Buy Now",
              //         style: TextStyle(
              //             fontSize: 14.4,
              //             fontFamily: 'Poppins',
              //             color: Colors.white)),
              //   ),
              // ),
              SizedBox(height: 5)
            ]),
          ),
        ));
  }
}
