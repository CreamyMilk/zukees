import 'package:flutter/material.dart';

class ManageTab extends StatefulWidget {
  ManageTab({Key key}) : super(key: key);

  @override
  _ManageTabState createState() => _ManageTabState();
}

class _ManageTabState extends State<ManageTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            PropertyManageCard(),
            EmployeeManageCard(),
            ContactAuctioner(),
          ],
        ),
      ),
    );
  }
}

class PropertyManageCard extends StatelessWidget {
  const PropertyManageCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 500,
        height: 180,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Manage Property 🏘",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.black),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(
                "312\nTotal Tenants",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              Text("26\nVaccant Houses",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
            ]),
            MaterialButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed('/alltenants', arguments: "brach number ");
                },
                child: Text("View All Tenants",
                    style: TextStyle(color: Colors.white)),
                color: Colors.lightBlue[400]),
          ],
        ),
      ),
    );
  }
}

class EmployeeManageCard extends StatelessWidget {
  const EmployeeManageCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Manage Employees👷‍♂️",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.black)),
          Container(
            height: 250,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  title: Text("John Kimani $index"),
                  subtitle: Text("🧹🧹🧹"),
                  trailing: Text("Ksh.9703"),
                  children: [
                    DataTable(
                      horizontalMargin: 1.0,
                      columns: [
                        DataColumn(label: Text('RollNo')),
                        DataColumn(label: Text('Name')),
                        DataColumn(label: Text('Class')),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('1')),
                          DataCell(Text('Arya')),
                          DataCell(Text('6')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('12')),
                          DataCell(Text('John')),
                          DataCell(Text('9')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('42')),
                          DataCell(Text('Tony')),
                          DataCell(Text('8')),
                        ]),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContactAuctioner extends StatelessWidget {
  const ContactAuctioner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Column(children: <Widget>[
          SizedBox(
            height: 90.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Image.asset(
                    'assets/matdesign_4.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 45.0,
                  left: 16.0,
                  right: 16.0,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Auctioner sample Card',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: const Text('📞 Contact Auctioner'),
              ),
            ],
          ),
        ]));
  }
}
