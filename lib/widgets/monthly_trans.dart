import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// Data class to visualize.
class _CostsData {
  final String category;
  final int cost;

  const _CostsData(this.category, this.cost);
}

class MonthlyTransChart extends StatefulWidget {
  MonthlyTransChart({Key key}) : super(key: key);

  @override
  _MonthlyTransChartState createState() => _MonthlyTransChartState();
}

class _MonthlyTransChartState extends State<MonthlyTransChart> {
  final List<_CostsData> _data = [
    const _CostsData('housingfdfdfdfdfdfdfdf', 1000),
    const _CostsData('food', 500),
    const _CostsData('health', 200),
    const _CostsData('trasport', 100),
  ];

  @override
  Widget build(BuildContext context) {
    final _colorPalettes =
        charts.MaterialPalette.getOrderedPalettes(this._data.length);
    return Card(
          child: SizedBox(
        height: 300,
        child: Stack(
          children: [
            charts.PieChart(
              // Pie chart can only render one series.
              /*seriesList=*/ [
                charts.Series<_CostsData, String>(
                  id: 'Sales-1',
                  colorFn: (_, idx) => _colorPalettes[idx].shadeDefault,
                  domainFn: (_CostsData sales, _) => sales.category,
                  measureFn: (_CostsData sales, _) => sales.cost,
                  data: this._data,
                  // Set a label accessor to control the text of the arc label.
                  labelAccessorFn: (_CostsData row, _) =>
                      '${row.category}: ${row.cost}',
                ),
              ],
              animate: true,
              defaultRenderer: charts.ArcRendererConfig(
                arcRatio: 0.5,
                arcRendererDecorators: [
                  charts.ArcLabelDecorator(
                      labelPosition: charts.ArcLabelPosition.auto)
                ],
              ),
              behaviors: [
                // Add title.
                charts.ChartTitle(
                  'November Transaction',
                  behaviorPosition: charts.BehaviorPosition.top,
                ),
                // Add legend. ("Datum" means the "X-axis" of each data point.)
                charts.DatumLegend(
                  position: charts.BehaviorPosition.end,
                  desiredMaxRows: 4,
                ),
              ],
            ),
            Positioned(
              top:150,
              left: 111,
              child: Text(
                "Total \nKsh 5.9090",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
