import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AllTenatsTable extends StatefulWidget {
  final String branch;
  const AllTenatsTable({Key key, @required this.branch}) : super(key: key);
  @override
  _AllTenatsTableState createState() => _AllTenatsTableState();
}

class _AllTenatsTableState extends State<AllTenatsTable> {
  Future _getTrans(String branchId) async {
    print('Branch $branchId');
    try {
      final response = await http.post(
        ("http://92.222.201.138:9001/tenants"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          {
            'branchid': branchId,
          },
        ),
      );
      var myjson = json.decode(response.body);
      //print(myjson);
      //print(response.body);
      return myjson;
    } catch (SocketException) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Sadly a Networking Error has occured."),
                //       actions: [MaterialButton(color:Colors.black,onPressed:(){AppSettings.openWIFISettings();},child:Text("Turn on",style:TextStyle(color:Colors.white)))],));
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("All Tenants👨‍💼"),
          bottom: TabBar(
            tabs: [
              Tab(text: "All"),
              Tab(text: "Defaulters"),
              Tab(text: "Evictions"),
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  child: TabBarView(children: [
                    FutureBuilder(
                        future: _getTrans(widget.branch),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return TwigList(
                                choice: true, apiData: snapshot.data);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                    FutureBuilder(
                        future: _getTrans(widget.branch),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return TwigList(
                                choice: true, apiData: snapshot.data);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        }),
                    FutureBuilder(
                        future: _getTrans(widget.branch),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            return TwigList(
                                choice: false, apiData: snapshot.data);
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        })
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TwigList extends StatelessWidget {
  final List<dynamic> apiData;
  final bool choice;
  const TwigList({
    @required this.apiData,
    Key key,
    @required this.choice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView.builder(
            itemCount: apiData.length,
            itemBuilder: (BuildContext context, int index) {
              return (choice
                  ? Container(
                      padding: EdgeInsets.only(left: 12.0),
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.check_circle,
                                      size: 12, color: Colors.green),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Tenant Name",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text("${apiData[index]["name"]}\n",
                                          textAlign: TextAlign.left),
                                      Text(" House No.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(" ${apiData[index]["unit"]}",
                                          textAlign: TextAlign.left),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Rent",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("${apiData[index]["rent"]}\n"),
                                  Text("Month",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(" ${apiData[index]["month"]} ",
                                      style: TextStyle(
                                          backgroundColor:
                                              apiData[index]["rentStatus"] != 0
                                                  ? Colors.lightGreen[200]
                                                  : Colors.red[200])),
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
                                onSelected: (o) async {
                                  final url =
                                      "tel:${apiData[index]["contacts"]}";
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
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
                          SizedBox(height: 4),
                          Divider(height: 1),
                        ],
                      ))
                  : null);
            },
          ),
        ),
      ],
    );
  }
}
