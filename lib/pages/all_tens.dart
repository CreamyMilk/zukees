import 'package:flutter/material.dart';

// Adapted from the data table demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/data_table_demo.dart
class DataTableExample extends StatefulWidget {
  const DataTableExample({Key key}) : super(key: key);

  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SafeArea(
                      child: SingleChildScrollView(
        child: PaginatedDataTable(
            header: const Text('Nutrition'),
            rowsPerPage: _rowsPerPage,
            availableRowsPerPage: const <int>[5, 10, 20,30],
            onRowsPerPageChanged: (int value) {
              setState(() {
                _rowsPerPage = value;
              });
            },
            columns: kTableColumns,
            source: DessertDataSource(),
        ),
      ),
          ),
    );
  }
}

////// Columns in table.
const kTableColumns = <DataColumn>[
  DataColumn(
    label: Text('Dessert (100g serving)'),
  ),
  DataColumn(
    label: Text('HouseNo'),
    tooltip: 'The total amount of food energy in the given serving size.',
    numeric: true,
  ),
  DataColumn(
    label: Text('Rent Paybaleb'),
    numeric: true,
  ),
  DataColumn(
    label: Text('Carbs (g)'),
    numeric: true,
  ),
  DataColumn(
    label: Text('Protein (g)'),
    numeric: true,
  ),

];

////// Data class.
class Dessert {
  Dessert(this.name, this.rent, this.fat, this.carbs, this.protein,
      );
  final String name;
  final int rent;
  final int fat;
  final int carbs;
  final double protein;

  bool selected = false;
}

////// Data source class for obtaining row data for PaginatedDataTable.
class DessertDataSource extends DataTableSource {
  int _selectedCount = 0;
  final List<Dessert> _desserts = <Dessert>[
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Jelly bean with sugar', 364, 99, 96, 99),
    Dessert('Total', 323232364, 01212120, 961212, 0121212.0),

  ];

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _desserts.length) return null;
    final Dessert dessert = _desserts[index];
    return DataRow.byIndex(
        index: index,
        selected: dessert.selected,
        onSelectChanged: (bool value) {
          if (dessert.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            dessert.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text(dessert.name)),
          DataCell(Text('${dessert.rent}')),
          DataCell(Text(dessert.fat.toStringAsFixed(1))),
          DataCell(Text('${dessert.carbs}')),
          DataCell(Text(dessert.protein.toStringAsFixed(1))),

        ]);
  }

  @override
  int get rowCount => _desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}