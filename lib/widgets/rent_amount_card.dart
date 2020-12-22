import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zukes/providers/rent_amounts_provider.dart';

class RentAmountCard extends StatefulWidget {
  @override
  _RentAmountCardState createState() => _RentAmountCardState();
}

class _RentAmountCardState extends State<RentAmountCard> {
  @override
  Widget build(BuildContext context) {
    final hBox = Provider.of<RentAmountP>(context);
    return Container(
        height: 160,
        child: ListView(
          children: [
            Divider(),
            ListTile(
              leading: Text("Paid"),
              trailing: Text("Ksh. ${hBox.paid}"),
            ),
            Divider(),
            ListTile(
              leading: Text("Due"),
              trailing: Text("Ksh. ${hBox.due}"),
            ),
            Divider()
          ],
        ));
  }
}
