import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Row;

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late List<Employee> _employees;
  late EmployeeDataSource _employeeDataSource;

  @override
  initState() {
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(_employees);
    super.initState();
  }

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();

  Future<void> exportDataGridToExcel() async {
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/DataGrid.xlsx';
    File(path).writeAsBytes(bytes);
    workbook.dispose();
    print('Excel file saved at $path');
  }

  Future<void> exportDataGridToPdf() async {
    final PdfDocument document = _key.currentState!.exportToPdfDocument();

    final List<int> bytes = await document.save();
    File('DataGrid.pdf').writeAsBytes(bytes);
    document.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Syncfusion Flutter DataGrid Export',
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(12.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                  width: 150.0,
                  child: MaterialButton(
                      color: Colors.blue,
                      onPressed: exportDataGridToExcel,
                      child: const Center(
                          child: Text(
                        'Export to Excel',
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
                const Padding(padding: EdgeInsets.all(20)),
                SizedBox(
                  height: 40.0,
                  width: 150.0,
                  child: MaterialButton(
                      color: Colors.blue,
                      onPressed: exportDataGridToPdf,
                      child: const Center(
                          child: Text(
                        'Export to PDF',
                        style: TextStyle(color: Colors.white),
                      ))),
                ),
              ],
            ),
          ),
          Expanded(
            child: SfDataGrid(
              source: _employeeDataSource,
              columns: <GridColumn>[
                GridColumn(
                    columnName: 'ID',
                    label: Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'ID',
                        ))),
                GridColumn(
                    columnName: 'Name',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Name'))),
                GridColumn(
                    columnName: 'Designation',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text(
                          'Designation',
                          overflow: TextOverflow.ellipsis,
                        ))),
                GridColumn(
                    columnName: 'Salary',
                    label: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: const Text('Salary'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Employee {
  final int id;
  final String name;
  final String email;
  final int sallary;

  Employee(this.id, this.name, this.email, this.sallary);
}

List<Employee> getEmployeeData() {
  return [
    Employee(1, "John Doe", "h6EYs@example.com", 5000),
    Employee(2, "Jane Smith", "h6EYs@example.com", 6000),
    Employee(3, "Alice Johnson", "h6EYs@example.com", 7000),
    Employee(4, "Bob Williams", "h6EYs@example.com", 8000),
    Employee(5, "Eve Brown", "h6EYs@example.com", 9000),
    Employee(6, "Charlie Davis", "h6EYs@example.com", 10000),
    Employee(7, "Frank Wilson", "h6EYs@example.com", 11000),
    Employee(8, "Grace Moore", "h6EYs@example.com", 12000),
    Employee(9, "Hank Thompson", "h6EYs@example.com", 13000),
    Employee(10, "Ivy Anderson", "h6EYs@example.com", 14000),
    Employee(11, "Jack Jackson", "h6EYs@example.com", 15000),
    Employee(12, "Katie Thompson", "h6EYs@example.com", 16000),
    Employee(13, "Liam Davis", "h6EYs@example.com", 17000),
    Employee(14, "Mia Wilson", "h6EYs@example.com", 18000),
    Employee(15, "Noah Anderson", "h6EYs@example.com", 19000),
    Employee(16, "Olivia Jackson", "h6EYs@example.com", 20000),
    Employee(17, "Parker Thompson", "h6EYs@example.com", 21000),
    Employee(18, "Quinn Davis", "h6EYs@example.com", 22000),
    Employee(19, "Riley Wilson", "h6EYs@example.com", 23000),
    Employee(20, "Sophia Anderson", "h6EYs@example.com", 24000),
  ];
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(List<Employee> employees) {
    dataGridRows = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: "id", value: e.id),
              DataGridCell<String>(columnName: "name", value: e.name),
              DataGridCell<String>(columnName: "email", value: e.email),
              DataGridCell<int>(columnName: "sallary", value: e.sallary),
            ]))
        .toList();
  }
  late List<DataGridRow> dataGridRows;

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row
            .getCells()
            .map<Widget>((e) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                alignment: (e.columnName == "id" || e.columnName == "salary")
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Text(
                  e.value.toString(),
                  overflow: TextOverflow.ellipsis,
                )))
            .toList());
  }
}
