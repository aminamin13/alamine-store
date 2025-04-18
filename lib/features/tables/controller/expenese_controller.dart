import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/expenese/data/model/expenses_model.dart';
import 'package:al_amine_store/features/expenese/data/source/expenses_data_source.dart';
import 'package:al_amine_store/functions/handlingdatacontroller.dart';
import 'package:al_amine_store/loaders/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

abstract class ExpeneseTableController extends GetxController {}

class ExpeneseTableControllerImpl extends ExpeneseTableController {
  StatusRequest statusRequest = StatusRequest.none;
  // Fetch product data
  ExpensesModel? expensesModel;
  List<ExpensesModel> allExpenese = [];
  late int total;

  ExpensesDataSource expenseData = ExpensesDataSource(Get.find());
  List<ExpensesModel> filteredExpenese = [];
  DateTime? selectedDate; // Default to null (no date selected)
  String selectedValue = "محل خلدة";

  viewData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await expenseData.viewData();
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          List datalist = response['data'];
          allExpenese = datalist.map((e) => ExpensesModel.fromJson(e)).toList();
          applyFilter(); // Apply filter after fetching data
        } else {
          null;
        }
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
    }

    update();
  }

  void applyFilter() {
    if (selectedValue == "all" && selectedDate == null) {
      filteredExpenese = List.from(
        allExpenese,
      ); // Show all data when no filter is applied
    } else {
      filteredExpenese =
          allExpenese.where((expense) {
            bool locationMatch =
                selectedValue == "all" || expense.location == selectedValue;
            bool dateMatch =
                selectedDate == null ||
                (expense.date!.day == selectedDate!.day &&
                    expense.date!.month == selectedDate!.month &&
                    expense.date!.year == selectedDate!.year);
            return locationMatch && dateMatch;
          }).toList();

      total = filteredExpenese.fold(
        0,
        (sum, expense) => sum + (expense.price ?? 0),
      );
    }
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
    update();
  }

  deleteData(String id) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await expenseData.deleteData(id);
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // Remove item from the list
          allExpenese.removeWhere((expense) => expense.id.toString() == id);
          filteredExpenese.removeWhere(
            (expense) => expense.id.toString() == id,
          );

          AppLoaders.successSnackBar(message: "98".tr, title: "34".tr);

          update(); // Update UI after deletion
        }
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
      AppLoaders.errorSnackBar(message: e.toString(), title: "36".tr);
    }
  }

  @override
  void onInit() {
    super.onInit();
    viewData();
    total = 0;
  }

  // goToSalesTablePage() {
  //   Get.toNamed("/salesTable", arguments: {'salesData': filteredSales});
  // }

  List<GridColumn> getColumns(double widthSize) {
    return <GridColumn>[
      GridColumn(
        width: widthSize,
        columnName: 'name',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Name',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ),
      GridColumn(
        width: widthSize,
        columnName: 'note',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Note',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      GridColumn(
        width: widthSize * 0.8,
        columnName: 'price',
        label: Container(
          padding: const EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Price',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
      ),
    ];
  }

  getExpenseDataSource() {
    return ExpenseDataGridSource(filteredExpenese);
  }
}

class ExpenseDataGridSource extends DataGridSource {
  late List<DataGridRow> dataGridRows;
  late List<ExpensesModel> expenseList;
  ExpenseDataGridSource(this.expenseList) {
    buildDataGridRow();
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  void buildDataGridRow() {
    dataGridRows = expenseList
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell(columnName: "name", value: dataGridRow.name),
              DataGridCell(columnName: "note", value: dataGridRow.note),
              DataGridCell(columnName: "price", value: dataGridRow.price),
            ],
          ),
        )
        .toList(growable: false);
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: [
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
      ],
    );
  }
}
