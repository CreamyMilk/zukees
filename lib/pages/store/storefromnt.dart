import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:zukes/models/product_search_model.dart';

import 'package:zukes/pages/store/getShopData.dart';
import 'package:zukes/pages/store/productCard.dart';
import 'package:zukes/providers/store_provider.dart';

class StoreFront extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            ProductSearchSection(),
            //ProductsCarossel(),
            ProductsListNew()
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
      height: MediaQuery.of(context).size.height * 0.291,
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
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
                  child: DropdownSearch<Data>(
                    label: "Search Here",
                    onFind: (String filter) async {
                      String endpointUrl = 'https:/store.i-crib.co.ke/serach';
                      Map<String, String> queryParams = {
                        'q': filter,
                      };
                      String queryString =
                          Uri(queryParameters: queryParams).query;

                      String requestUrl = endpointUrl + '?' + queryString;
                      var response = await get(requestUrl);

                      var models = ProductSearchModel.fromJson(
                          json.decode(response.body));
                      return models.data;
                    },
                    onChanged: (Data data) {
                      print(data);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text("Categories",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w300)),
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

class ProductsListNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(builder: (context, storeP, child) {
      return FutureBuilder(
          future: storeP.getAllProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //print("${snapshot.data}");
              return Container(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                height: MediaQuery.of(context).size.height * 0.7,
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
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(4.0),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              amount: snapshot.data[index]["amount"],
                              heros: snapshot.data[index]["product_id"],
                              prodname: snapshot.data[index]["product_name"],
                              imageUrl: snapshot.data[index]["product_image"],
                              productID: snapshot.data[index]["product_id"],
                              packingType: snapshot.data[index]
                                  ["product_packtype"],
                            );
                          }),
                    ),
                  ],
                ),
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
    });
  }
}

class CategoriesListNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAllCategories(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //print("${snapshot.data}");
            return Container(
              height: 80,
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
          padding: const EdgeInsets.all(2.0),
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
                  widget.imageUrl,
                  fit: BoxFit.scaleDown,
                  width: 10,
                  height: 10,
                ),
              ),
            ),
          ),
        ),
        Text("${widget.prodname}",
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
