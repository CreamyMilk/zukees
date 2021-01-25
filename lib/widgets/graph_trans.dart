import 'dart:math';

/// Package import
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Renders the doughnut chart with legend
class CoolGraph extends StatefulWidget {
  final String firestoreKey;
  CoolGraph({Key key, @required this.firestoreKey}) : super(key: key);

  @override
  _CoolGraphState createState() => _CoolGraphState();
}

class _CoolGraphState extends State<CoolGraph> {
  _CoolGraphState();
  Query query;
  String _monthvalue;
  String _yearvalue;
  @override
  void initState() {
    _monthvalue = DateFormat('MMMM').format(DateTime.now());
    _yearvalue = DateFormat('y').format(DateTime.now());
    query = FirebaseFirestore.instance.collection(widget.firestoreKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(widget.firestoreKey)
                      .where("year", isEqualTo: _yearvalue)
                      .where("month", isEqualTo: _monthvalue)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return _getCoolGraphChart("", "", 1, 1);
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }
                    QuerySnapshot querySnapshot = snapshot.data;
                    if (querySnapshot.docs.length >= 1) {
                      var _da = querySnapshot.docs[0].data();
                      return _getCoolGraphChart(
                        _da["month"],
                        _da["year"],
                        _da["paymentData"]["paid"].toDouble(),
                        _da["paymentData"]["due"].toDouble(),
                      );
                    } else {
                      return _getCoolGraphChart("", "", 1, 1);
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection(widget.firestoreKey)
                              .where("year", isEqualTo: _yearvalue)
                              .get(),
                          builder: (context, snapshot) {
                            List<DropdownMenuItem<String>> temp = [];
                            List tt = [];
                            if (snapshot.hasData) {
                              if (snapshot.data.docs.length >= 1) {
                                if ((tt.indexWhere((m) => m == _monthvalue)) ==
                                    -1) {
                                  print("Final loop");
                                  temp.add(
                                    DropdownMenuItem<String>(
                                      value: _monthvalue,
                                      child: Text(_monthvalue),
                                    ),
                                  );
                                  snapshot.data.docs.forEach((doc) {
                                    tt.add(doc["month"]);
                                    _monthvalue != doc["month"]
                                        ? temp.add(
                                            DropdownMenuItem<String>(
                                              value: doc["month"],
                                              child: Text(doc["month"]),
                                            ),
                                            // ignore: unnecessary_statements
                                          )
                                        : Text("");
                                  });
                                } else {
                                  snapshot.data.docs.forEach((doc) {
                                    tt.add(doc["month"]);
                                    temp.add(
                                      DropdownMenuItem<String>(
                                        value: doc["month"],
                                        child: Text(doc["month"]),
                                      ),
                                    );
                                  });
                                }
                              } else {
                                print("The data length is below 1");
                              }
                            } else {
                              print("No data");
                            }
                            return DropdownButton<String>(
                                value: _monthvalue,
                                underline: const SizedBox(height: 1),
                                items: temp,
                                onChanged: (String n) {
                                  setState(() {
                                    _monthvalue = n;
                                    // _temp = 90;
                                  });
                                });
                          }),
                      color: Colors.white),
                  MaterialButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection(widget.firestoreKey)
                              .get(),
                          builder: (context, snapshot) {
                            List<dynamic> tempApi = [];
                            List<DropdownMenuItem<String>> tempYear = [];
                            if (snapshot.hasData) {
                              snapshot.data.docs.forEach((doc) {
                                //print(doc["month"]);

                                tempApi.add(doc["year"]);
                              });
                              tempApi.toSet().toList().forEach((a) {
                                tempYear.add(
                                  DropdownMenuItem<String>(
                                    value: a,
                                    child: Text(a),
                                  ),
                                );
                              });
                            } else {
                              print("ok");
                            }
                            return DropdownButton<String>(
                                value: _yearvalue,
                                items: tempYear,
                                underline: const SizedBox(height: 1),
                                onChanged: (String n) {
                                  setState(() {
                                    _yearvalue = n;
                                  });
                                });
                          }),
                      color: Colors.white),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Card(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(widget.firestoreKey)
                  .where("year", isEqualTo: _yearvalue)
                  .where("month", isEqualTo: _monthvalue)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _getVisualAmounts(1.0, 1.0);
                }

                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }

                QuerySnapshot querySnapshot = snapshot.data;
                if (querySnapshot.docs.length >= 1) {
                  var _da = querySnapshot.docs[0].data();
                  return _getVisualAmounts(
                    _da["paymentData"]["paid"].toDouble(),
                    _da["paymentData"]["due"].toDouble(),
                  );
                } else {
                  return _getVisualAmounts(1.0, 1.0);
                }
              }),
        ),
      ],
    );
  }

  Container _getVisualAmounts(double paid, double due) {
    const TextStyle beBold =
        TextStyle(fontSize: 19, fontWeight: FontWeight.w500);
    const TextStyle beGreen = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w500, color: Colors.green);
    const TextStyle beRed =
        TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.red);
    return Container(
        height: 150,
        child: ListView(children: [
          Divider(),
          ListTile(
              leading: Text("Paid", style: beBold),
              trailing: Text("+Ksh. $paid", style: beGreen)),
          Divider(),
          ListTile(
              leading: Text("Due", style: beBold),
              trailing: Text("-Ksh. $due", style: beRed)),
        ]));
  }

  ///Get the default circular series with legend
  SfCircularChart _getCoolGraphChart(
      String month, String year, double paid, double due) {
    //print("Hox value = Paid ${hBox.paid}");
    double total = paid + due;
    double paidtemp = (paid / (paid + due)) * 100;
    double mod = pow(10.0, 2);
    double paidpercentage = ((paidtemp * mod).round().toDouble() / mod);
    //print("Perc $paidpercentage");
    return SfCircularChart(
      title: ChartTitle(text: '$month $year Earnings'),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: _getCoolGraphSeries(paidpercentage),
      annotations: [
        CircularChartAnnotation(
            widget: Container(
                child: Text('Expected.\n$total\nKSH',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10))))
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  ///Get the default circular series
  List<DoughnutSeries<ChartSampleData, String>> _getCoolGraphSeries(
      double paidperc) {
    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(
          x: 'Paid ', y: paidperc, pointColor: Colors.green, xValue: "Rnadom"),
      ChartSampleData(x: 'Due', y: 100 - paidperc, pointColor: Colors.red),
    ];
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
          innerRadius: "70%",
          dataSource: chartData,
          strokeColor: Colors.red,
          xValueMapper: (ChartSampleData data, _) => data.x,
          yValueMapper: (ChartSampleData data, _) => data.y,
          pointColorMapper: (ChartSampleData data, _) => data.pointColor,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: DataLabelSettings(
              isVisible: true, labelPosition: ChartDataLabelPosition.outside)),
    ];
  }
}

class ChartSampleData {
  /// Holds the datapoint values like x, y, etc.,
  ChartSampleData(
      {this.x,
      this.y,
      this.xValue,
      this.yValue,
      this.secondSeriesYValue,
      this.thirdSeriesYValue,
      this.pointColor,
      this.size,
      this.text,
      this.open,
      this.close,
      this.low,
      this.high,
      this.volume});

  /// Holds x value of the datapoint
  final dynamic x;

  /// Holds y value of the datapoint
  final num y;

  /// Holds x value of the datapoint
  final dynamic xValue;

  /// Holds y value of the datapoint
  final num yValue;

  /// Holds y value of the datapoint(for 2nd series)
  final num secondSeriesYValue;

  /// Holds y value of the datapoint(for 3nd series)
  final num thirdSeriesYValue;

  /// Holds point color of the datapoint
  final Color pointColor;

  /// Holds size of the datapoint
  final num size;

  /// Holds datalabel/text value mapper of the datapoint
  final String text;

  /// Holds open value of the datapoint
  final num open;

  /// Holds close value of the datapoint
  final num close;

  /// Holds low value of the datapoint
  final num low;

  /// Holds high value of the datapoint
  final num high;

  /// Holds open value of the datapoint
  final num volume;
}

class SalesData {
  SalesData(this.x, this.y, [this.date, this.color]);
  final dynamic x;
  final dynamic y;
  final Color color;
  final DateTime date;
}
