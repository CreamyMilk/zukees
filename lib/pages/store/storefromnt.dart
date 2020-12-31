import 'package:flutter/material.dart';

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

TextStyle ourStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15.0);
TextStyle productsNameStyle =
    TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20.0);

class ProductSearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(text: "Our", style: ourStyle),
            TextSpan(text: "Products", style: productsNameStyle),
          ]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 5),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: null,
            ),
            SizedBox(width: 25),
            Flexible(
              flex: 10,
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
            SizedBox(width: 5),
          ],
        ),
        Text("Categories",
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
        CategoriesList(),
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
        CategoryTile(),
        CategoryTile(),
        CategoryTile(),
        // SizedBox(
        //   width: 10,
        // ),
        // PaymentTile(),
      ],
    );
  }
}

class CategoryTile extends StatefulWidget {
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
            height: 20,
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
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Products",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          ListView(
            padding: EdgeInsets.all(4.0),
            scrollDirection: Axis.horizontal,
            children: [ProductCard(), ProductCard()],
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100, width: 50, color: Colors.red, child: Text("one"));
  }
}
