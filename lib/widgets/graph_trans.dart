/// Package import
import 'package:flutter/material.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

/// Renders the doughnut chart with legend
class CoolGraph extends StatefulWidget {
  /// Creates the doughnut chart with legend
  //const CoolGraph(Key key) : super(key: key);

  @override
  _CoolGraphState createState() => _CoolGraphState();
}

class _CoolGraphState extends State<CoolGraph> {
  _CoolGraphState();
  static const _months = <String>[
    'January',
    'Febuary',
    'December',
  ];
  static const _years = <String>["2018", "2019", "2020", "2021"];
  final List<DropdownMenuItem<String>> _dropDownMonth = _months
      .map(
        (String v) => DropdownMenuItem<String>(
          value: v,
          child: Text(v),
        ),
      )
      .toList();
  final List<DropdownMenuItem<String>> _dropDownYear = _years
      .map(
        (String v) => DropdownMenuItem<String>(
          value: v,
          child: Text(v),
        ),
      )
      .toList();
  String _monthvalue = "January";
  String _yearvalue = "2021";
  double _temp =56.2;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _getCoolGraphChart(_monthvalue,_yearvalue,_temp),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: DropdownButton<String>(
                      value: _monthvalue,
                      underline:const SizedBox(height:1),
                      items: _dropDownMonth,
                      onChanged: (String n) {
                        setState(() {
                          _monthvalue = n;
                          _temp = 90;
                        });
                      }),
                  color: Colors.white),
              MaterialButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(50.0),
                ),
                child: DropdownButton<String>(
                    value: _yearvalue,
                    items: _dropDownYear,
                    underline:const SizedBox(height:1),
                    onChanged: (String n) {
                      setState(() {
                        _yearvalue = n;
                      });
                    }),
                    color: Colors.white
              ),
            ],
          ),
          SizedBox(height:10),
        ],
      ),
    );
  }

  ///Get the default circular series with legend
  SfCircularChart _getCoolGraphChart(String month,String year,double rand) {
    return SfCircularChart(
      title: ChartTitle(text: '$month $year Earnings'),
      legend:
          Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
      series: _getCoolGraphSeries(rand),
      annotations: [
        CircularChartAnnotation(
            widget: Container(
                child: Text('Total\n9,643,434,343\nKSH',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10))))
      ],
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  ///Get the default circular series
  List<DoughnutSeries<ChartSampleData, String>> _getCoolGraphSeries(double temp) {
    final List<ChartSampleData> chartData = <ChartSampleData>[
          ChartSampleData(x: 'Paid ', y: temp,pointColor: Colors.green),
      ChartSampleData(x: 'Due', y: 100-temp, pointColor: Colors.red),

  

    ];
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
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
