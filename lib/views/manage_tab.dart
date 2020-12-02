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
            //PropertyManageCard(),
            Text("Hello from managment👋\n\n"),
            NewPropertCard(),
            EmployeeManageCard(),
            //CoolListTile(),
            ContactAuctioner(),
          ],
        ),
      ),
    );
  }
}

class NewPropertCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DataTile(
                    label: "Total Tenants",
                    value: 300,
                  ),
                  Container(
                    height: 60.0,
                    width: 1.0,
                    color: Colors.blueGrey,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  ),
                  DataTile(label: "Vaccant Houses", value: 12)
                ],
              ),
              SizedBox(height: 20),
              Text("As at 02:51 PM"),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/alltens', arguments: "8");
                  },
                  child: Text("View All Tenants 📩",
                      style: TextStyle(color: Colors.black)),
                  color: Colors.white),
            ],
          ),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.blue),
            ),
          )),
    );
  }
}

class DataTile extends StatelessWidget {
  final String label;
  final int value;
  const DataTile({
    Key key,
    @required this.label,
    @required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        Text(label,
            textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
        SizedBox(height: 10),
        Text(value.toString(),
            style: TextStyle(fontSize: 35, color: Colors.lightBlue))
      ],
    ));
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
                  title: Text("Good Worker $index"),
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

class CoolListTile extends StatelessWidget {
  const CoolListTile({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return Card(
      child: TwigList(),
    );
  }
}

class TwigList extends StatelessWidget {
  const TwigList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
      
        Container(
          height: 770,
          child: ListView.builder(
            itemCount: 70,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.only(left:12.0),
                  height: 64,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height:4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.check_circle,
                                  size: 12, color: Colors.green),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Tenant Name",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(" Patrick werwer,wer\n",
                                      textAlign: TextAlign.left),
                                  Text(" House No.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(" A2", textAlign: TextAlign.left),
                                ],
                              ),
                            ],
                          ),
                          Column(
                              mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Rent",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("450,000\n"),
                              Text("Month",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(" January ",
                                  style: TextStyle(
                                      backgroundColor: Colors.lightGreen[200])),
                            ],
                          ),
                          Column(
                              mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("--"),
                            ],
                          ),
                          PopupMenuButton<String>(
                            onSelected: (o) {
                              print(o);
                            },
                            itemBuilder: (BuildContext context) {
                              return {'Contact'}.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height:4),
                      Divider(height:1),
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}
