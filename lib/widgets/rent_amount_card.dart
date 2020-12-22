import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zukes/providers/rent_amounts_provider.dart';

class RentAmountsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rBox = Provider.of<RentAmountP>(context);
    return Card(
      child: Column(
        children: [
          ListView(
            children: [
              ListTile(
                leading: Text("Paid"),
                trailing: Text("Ksh.${rBox.paid}"),
              ),
              ListTile(
                leading: Text("Due"),
                trailing: Text("Ksh.${rBox.due}"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
