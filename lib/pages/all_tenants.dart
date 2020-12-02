import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:zukes/models/tenantData.dart';
import 'package:zukes/views/manage_tab.dart';

class AllTenatsTable extends StatefulWidget {
  final String branch;
  const AllTenatsTable({Key key, @required this.branch}) : super(key: key);
  @override
  _AllTenatsTableState createState() => _AllTenatsTableState();
}

class _AllTenatsTableState extends State<AllTenatsTable> {
  Future _getTrans(String branchId) async {
    TenantData data;
    print('Branch $branchId');
    try {
      final response = await http.post(
        ("http://kkk.i-crib.co.ke/" + "acc"),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
        },
        body: jsonEncode(
          {
            'branchId': branchId,
          },
        ),
      );
      var myjson = json.decode(response.body);
      data = TenantData.fromJson(myjson);
      print(response.body);
    } catch (SocketException) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("No Network connection."),
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
                      if (snapshot.data == null) {
                        return TwigList();
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
