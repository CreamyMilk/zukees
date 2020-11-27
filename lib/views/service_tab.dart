import 'package:flutter/material.dart';

class ServiceTab extends StatefulWidget {
  ServiceTab({Key key}) : super(key: key);

  @override
  _ServiceTabState createState() => _ServiceTabState();
}

class _ServiceTabState extends State<ServiceTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          PropertyCard(),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("lklkslk"),
                Container(
                  height: 300,
                  child: ListView.builder(
                    itemCount: 115,
                    itemBuilder: (BuildContext context, int index) {
                      return ExpansionTile(
                        title: Text("Too $index"),
                        subtitle: Text("😁😁😁"),
                        trailing: Text("Cleaning"),
                        children: [
                         Text("sdsd"),
                         Text("sdsdsdsd"),
            DataTable(
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
          ),
        ],
      ),
    );
  }
}

class EmployessCard extends StatelessWidget {
  const EmployessCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Manage Employees👩‍🏭"),
          ],
        ),
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  const PropertyCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Manage Property🏘"),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text("312\nTotal Tenant"),
              Text("26\nVaccant Houses"),
            ]),
            MaterialButton(
                onPressed: () {},
                child: Text("View All Tenants"),
                color: Colors.green),
          ],
        ),
      ),
    );
  }
}

class CoolGridValue extends StatefulWidget {
  @override
  _CoolGridValueState createState() => _CoolGridValueState();
}

class _CoolGridValueState extends State<CoolGridValue> {
  double _cwidth;
  @override
  void initState() {
    _cwidth = 90;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("pressed");
        setState(() {
          _cwidth = _cwidth + 45;
        });
      },
      child: AnimatedContainer(
          duration: Duration(seconds: 1), height: _cwidth, color: Colors.green),
    );
  }
}
