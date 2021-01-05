import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:provider/provider.dart';
import 'package:zukes/providers/store_provider.dart';

class ProductCard extends StatefulWidget {
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
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  AnimationController _myanimationcontrol;

  @override
  void initState() {
    _myanimationcontrol =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _myanimationcontrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation =
        Tween<double>(begin: 0.1, end: 1.0).animate(_myanimationcontrol);
    double _getHeight(double value) {
      if (value == 1) {
        return 1.0;
      } else if (value > 0.7) {
        return 0.8;
      } else {
        return 1;
      }
    }

    return InkWell(
      onTapCancel: () {
        print("Tap canncelled");
      },
      onTap: () {
        print("Adding item to cart here");
        //_myanimationcontrol.forward();
      },
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, snapshot) {
            return AnimatedContainer(
                duration: Duration(seconds: 1),
                height: 600 * _getHeight(animation.value),
                width: 200 * _getHeight(animation.value),
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  height: 200 * _getHeight(animation.value),
                                  width: 200 * _getHeight(animation.value),
                                  color: Colors.transparent,
                                  child: BlurHash(
                                      color: Colors.transparent,
                                      hash: """LXP~\$byZ?aM|_4x]R%Vs%OX3RQt6""",
                                      image: widget.imageUrl)),
                              SizedBox(height: 3),
                              Text("\$ ${widget.amount}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 24)),
                              SizedBox(height: 3),
                              Text(widget.prodname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15)),
                              SizedBox(height: 13),
                              Text(widget.packingType,
                                  style: TextStyle(color: Colors.grey)),
                              Spacer(),
                              Row(
                                children: [
                                  Spacer(),
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
                    ),
                    Positioned(
                      right: 4.0,
                      bottom: 4.0,
                      child: ChangeNotifierProvider<StoreProvider>(
                          create: (context) => StoreProvider(),
                          builder: (context, snapshot) {
                            final storeP = Provider.of<StoreProvider>(context);
                            int counter = storeP.quantityOfProduct("1");
                            return AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8))),
                                width: 40,
                                height: counter == 0 ? 45 : 100,
                                child: Column(children: [
                                  counter != 0
                                      ? IconButton(
                                          onPressed: () {
                                            storeP.decrementFromCart("1");
                                          },
                                          icon: Icon(Icons.remove,
                                              color: Colors.white),
                                        )
                                      : Container(),
                                  counter != 0
                                      ? Text(
                                          "0$counter",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : Container(),
                                  IconButton(
                                    onPressed: () {
                                      storeP.addToCart("1");
                                    },
                                    icon: Icon(Icons.add, color: Colors.white),
                                  )
                                ]));
                          }),
                    ),
                  ],
                ));
          }),
    );
  }
}
