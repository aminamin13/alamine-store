// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/sales/data/datasource/sales_datasource.dart';
import 'package:al_amine_store/features/sales/data/model/sales_model.dart';
import 'package:al_amine_store/functions/handlingdatacontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SalesTableControllerImp extends GetxController {
  SalesDataSource salesData = SalesDataSource(Get.find());
  StatusRequest statusRequest = StatusRequest.none;

  String selectedValue = "محل خلدة";
  DateTime? selectedDate; // Default to null (no date selected)
  static List<SalesModel> filteredSales = [];
  List<SalesModel> allSales = [];
  SalesModel? salesModel;
  late Map<String, dynamic> arguments;
  late String id;

  late int total;

  viewData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await salesData.viewData();
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          List datalist = response['data'];
          print(datalist);
          allSales = datalist.map((e) => SalesModel.fromJson(e)).toList();
          //applyFilter(); // Apply filter after fetching data
        } else {
          null;
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  void applyFilter() {
    if (selectedValue == "all" && selectedDate == null) {
      filteredSales =
          List.from(allSales); // Show all data when no filter is applied
    } else {
      filteredSales = allSales.where((sale) {
        bool locationMatch =
            selectedValue == "all" || sale.salesItemLocation == selectedValue;
        bool dateMatch = selectedDate == null ||
            (sale.salesDate!.day == selectedDate!.day &&
                sale.salesDate!.month == selectedDate!.month &&
                sale.salesDate!.year == selectedDate!.year);
        return locationMatch && dateMatch;
      }).toList();
    }
    total = filteredSales.fold(0, (sum, sale) => sum + (sale.salesProfit ?? 0));
    update(); // Update UI
  }

  void updateSelectedDate(DateTime? newDate) {
    selectedDate = newDate;
    applyFilter();
  }

  void clearFilters() {
    selectedValue = "محل خلدة"; // Default location
    selectedDate = null; // Reset date filter
    applyFilter(); // Reapply filter with default values
    print("total sales is : $total");
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    viewData();
    total = 0;
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          width: 100,
          columnName: 'name',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ))),
      GridColumn(
          width: 100,
          columnName: 'customer',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: const Text('Costumer',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  overflow: TextOverflow.ellipsis))),
      GridColumn(
          width: 80,
          columnName: 'price',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Price',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ))),
      GridColumn(
          width: 80,
          columnName: 'profite',
          label: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Profite',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              )))
    ];
  }

  getSalesDataSource() {
    return SalesDataGridSource(filteredSales);
  }
}

class SalesDataGridSource extends DataGridSource {
  late List<DataGridRow> dataGridRows;
  late List<SalesModel> salesList;
  SalesDataGridSource(this.salesList) {
    buildDataGridRow();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = salesList
        .map<DataGridRow>((dataGridRow) => DataGridRow(cells: [
              DataGridCell(
                  columnName: "name", value: dataGridRow.salesItemName),
              DataGridCell(
                  columnName: "customer", value: dataGridRow.salesCustomer),
              DataGridCell(columnName: "price", value: dataGridRow.salesPrice),
              DataGridCell(
                  columnName: "profite", value: dataGridRow.salesProfit),
            ]))
        .toList(growable: false);
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[0].value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[1].value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[2].value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          row.getCells()[3].value.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          overflow: TextOverflow.ellipsis,
        ),
      )
    ]);
  }
}
