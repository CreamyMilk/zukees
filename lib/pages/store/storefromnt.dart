import 'package:flutter/material.dart';

class StoreFront extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
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
      height: MediaQuery.of(context).size.height * 0.3,
      child: Column(children: [
        Text("Our\nProducts"),
        Row(children: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          ),
          SizedBox(width: 10),
          TextField(
            decoration: InputDecoration(hintText: 'Search For Products'),
          )
        ]),
        Text("Categories", style: TextStyle(color: Colors.black)),
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
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          minWidth: 25,
          height: 30,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: _enabled
                  ? BorderSide(color: Colors.red)
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
              width: 45,
              height: 35,
              child: Image.asset(
                'assets/mpesa.png',
                fit: BoxFit.scaleDown,
                width: 10,
                height: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductsCarossel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        children: [
          Text("Products", style: TextStyle(color: Colors.black)),
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
    return Container();
  }
}
