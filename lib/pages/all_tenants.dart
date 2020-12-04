import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

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
      final response = await http.get(
        ("https://kkk.i-crib.co.ke/a"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        // body: jsonEncode(
        //   {
        //     'branchId': branchId,
        //   },
        // ),
      );
      var myjson = json.decode(response.body);
      //print(myjson);
      //print(response.body);
      return myjson;
    } catch (SocketException) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Network Error."),
                //       actions: [MaterialButton(color:Colors.black,onPressed:(){AppSettings.openWIFISettings();},child:Text("Turn on",style:TextStyle(color:Colors.white)))],));
              ));
              
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Tenants👨‍💼")),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              child: Container(
                height: 786,
                child: FutureBuilder(
                    future: _getTrans(widget.branch),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return TwigList(apiData:snapshot.data);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TwigList extends StatelessWidget {
  final List<dynamic> apiData;
  const TwigList({
    @required this.apiData,
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
            itemCount: apiData.length,
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
                                  Text("${apiData[index]["r_name"]}\n",
                                      textAlign: TextAlign.left),
                                  Text(" House No.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text(" ${apiData[index]["unit_no"]}", textAlign: TextAlign.left),
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text("${apiData[index]["total_rent"]}\n"),
                              Text("Month",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(" ${apiData[index]["month_name"]} ",
                                  style: TextStyle(
                                      backgroundColor:apiData[index]["month_name"] == DateFormat('MMMM').format(DateTime.now())? Colors.lightGreen[200]:Colors.red[200])),
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
                              print(" ${apiData[index]["r_contact"]} ");
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
