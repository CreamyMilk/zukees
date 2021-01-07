import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:provider/provider.dart';
import 'package:zukes/providers/store_provider.dart';
//import 'package:intl/intl.dart';

const _startColumnWidth = 60.0;
const _ordinalSortKeyName = 'shopping_cart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  // List<Widget> _createShoppingCartRows() {
  //   return [
  //     ShoppingCartRow(
  //       product: Product(
  //           category: "null",
  //           id: 1,
  //           isFeatured: true,
  //           name: (_) {
  //             return "Item Name";
  //           },
  //           price: 11),
  //       quantity: 3,
  //       onPressed: () {
  //         // model.removeItemFromCart(id);
  //       },
  //     ),
  //   ];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
            child: Stack(
          children: [
            ListView(
              children: [
                Semantics(
                  sortKey: const OrdinalSortKey(0, name: _ordinalSortKeyName),
                  child: Row(
                    children: [
                      SizedBox(
                        width: _startColumnWidth,
                        child: IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        //ExpandingBottomSheet.of(context).close(),
                        // tooltip: GalleryLocalizations.of(context)
                        //     .shrineTooltipCloseCart,
                      ),
                      Text(
                        "Cart",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 13),
                      ),
                      const SizedBox(width: 16),
                      Consumer<StoreProvider>(
                          builder: (context, storeP, child) {
                        return Text(
                          "${storeP.numberOfProducts()} ITEMS",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 11),
                        );
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Consumer<StoreProvider>(builder: (context, storeP, child) {
                  return Container(
                      height: 120 * storeP.cart.length.toDouble(),
                      child: ListView.builder(
                          itemCount: storeP.cart.length,
                          itemBuilder: (context, index) {
                            //Cart Builder
                            final allKeys = storeP.cart.keys.toList();
                            final String productID = allKeys[index];
                            final Map<String, dynamic> cartItem =
                                storeP.cart[productID];
                            return ShoppingCartRow(
                              product: Product(
                                category: cartItem["product_name"],
                                id: cartItem["product_id"].toString(),
                                isFeatured: true,
                                name: (_) {
                                  return cartItem["product_name"];
                                },
                                price: cartItem["amount"],
                              ),
                              quantity: storeP.cart[productID],
                              onPressed: () {
                                storeP.removeFromCart(productID);
                              },
                            );
                          }));
                }),
                const SizedBox(height: 100),
                ShoppingCartSummary(),
              ],
            ),
            PositionedDirectional(
              bottom: 16,
              start: 16,
              end: 16,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  primary: Colors.green[400],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    "CHECKOUT",
                    style: TextStyle(letterSpacing: 1.0),
                  ),
                ),
                onPressed: () {
                  // model.clearCart();
                  // ExpandingBottomSheet.of(context).close();
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}

class ShoppingCartSummary extends StatelessWidget {
  const ShoppingCartSummary();

  @override
  Widget build(BuildContext context) {
    final smallAmountStyle =
        Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.brown);
    final largeAmountStyle = Theme.of(context)
        .textTheme
        .headline4
        .copyWith(color: Colors.green[900], letterSpacing: 0.0);
    // final formatter = NumberFormat.simpleCurrency(
    //   decimalDigits: 2,
    //   locale: Localizations.localeOf(context).toString(),
    // );

    return Row(
      children: [
        const SizedBox(width: _startColumnWidth),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(end: 16),
            child: Column(
              children: [
                MergeSemantics(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "TOTAL",
                        style: TextStyle(fontSize: 20),
                      ),
                      Expanded(
                        child: Text(
                          "\$910.85",
                          style: largeAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                MergeSemantics(
                  child: Row(
                    children: [
                      Text("Subtotal:"),
                      Expanded(
                        child: Text(
                          "\$54.00",
                          style: smallAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                MergeSemantics(
                  child: Row(
                    children: [
                      Text("Shipping:"),
                      Expanded(
                        child: Text(
                          "\$54.00",
                          style: smallAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                MergeSemantics(
                  child: Row(
                    children: [
                      Text("Tax:"),
                      Expanded(
                        child: Text(
                          "\$4.48",
                          style: smallAmountStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ShoppingCartRow extends StatelessWidget {
  const ShoppingCartRow({
    @required this.product,
    @required this.quantity,
    this.onPressed,
  });

  final Product product;
  final int quantity;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // final formatter = NumberFormat.simpleCurrency(
    //   decimalDigits: 0,
    //   locale: Localizations.localeOf(context).toString(),
    // );
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        key: ValueKey<String>(product.id), //Changed Types for better parsing
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _startColumnWidth,
            child: IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: onPressed,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        "https://shop.twiga.ke/static/ac2803e0375850278fe923c52490784b/8ea22/eddacd9e-8170-4e1d-8cad-0a550d5c2a461604472076.52438.webp",
                        fit: BoxFit.cover,
                        width: 75,
                        height: 75,
                        excludeFromSemantics: true,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text("Quantity:  $quantity",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 11)),
                                ),
                                Text(
                                  "x \$${product.price}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Text(
                              product.name(context),
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(
                    color: Colors.brown,
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  const Product({
    @required this.category,
    @required this.id,
    @required this.isFeatured,
    @required this.name,
    @required this.price,
    this.assetAspectRatio = 1,
  })  : assert(category != null),
        assert(id != null),
        assert(isFeatured != null),
        assert(name != null),
        assert(price != null),
        assert(assetAspectRatio != null);

  final String category;
  final String id;
  final bool isFeatured;
  final double assetAspectRatio;

  // A function taking a BuildContext as input and
  // returns the internationalized name of the product.
  final String Function(BuildContext) name;

  final int price;
}
