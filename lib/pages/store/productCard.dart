import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

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
      if (value > 0.7) {
        return 1.1;
      } else if (value > 0.5) {
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
        _myanimationcontrol.forward();
      },
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, snapshot) {
            return AnimatedContainer(
                duration: Duration(seconds: 1),
                height: 600 * _getHeight(animation.value),
                width: 200 * _getHeight(animation.value),
                color: Colors.transparent,
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AnimatedContainer(
                              duration: Duration(seconds: 1),
                              height: 600 * _getHeight(animation.value),
                              width: 200 * _getHeight(animation.value),
                              color: Colors.transparent,
                              child: BlurHash(
                                  color: Colors.transparent,
                                  hash: """LXP~\$byZ?aM|_4x]R%Vs%OX3RQt6""",
                                  image: widget.imageUrl)),
                          SizedBox(height: 3),
                          Text("\$ ${widget.amount}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 24)),
                          SizedBox(height: 3),
                          Text(widget.prodname,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 15)),
                          SizedBox(height: 13),
                          Text(widget.packingType,
                              style: TextStyle(color: Colors.grey)),
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
          }),
    );
  }
}
