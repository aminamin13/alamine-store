import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/sales/data/datasource/sales_datasource.dart';
import 'package:al_amine_store/features/sales/data/model/sales_model.dart';
import 'package:al_amine_store/functions/handlingdatacontroller.dart';
import 'package:al_amine_store/loaders/snackbar.dart';
import 'package:get/get.dart';

abstract class ExpeneseTableController extends GetxController {}

class ExpeneseTableControllerImpl extends ExpeneseTableController {
  static ExpeneseTableControllerImpl get instance => Get.find();

  StatusRequest statusRequest = StatusRequest.none;
  // Fetch product data
  SalesModel? salesModel;
  List<SalesModel> allSales = [];

  SalesDataSource salesData = SalesDataSource(Get.find());
  List<SalesModel> filteredSales = [];
  DateTime? selectedDate; // Default to null (no date selected)
  String selectedValue = "محل خلدة";

  viewData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await salesData.viewData();
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          List datalist = response['data'];
          allSales = datalist.map((e) => SalesModel.fromJson(e)).toList();
          //applyFilter(); // Apply filter after fetching data
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
    update(); // Update UI
  }

  void updateSelectedDate(DateTime? newDate) {
    selectedDate = newDate;
    applyFilter();
  }

  editItemCountNumber(
    String id,
  ) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await salesData.editCountNumber(
        id,
      );
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          update(); // Update UI after deletion
        }
      }
    } catch (e) {
      statusRequest = StatusRequest.failure;
    }
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
      var response = await salesData.deleteData(
        id,
      );
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // Remove item from the list
          allSales.removeWhere((sale) => sale.salesId.toString() == id);
          filteredSales.removeWhere((sale) => sale.salesId.toString() == id);

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
  }

  // goToSalesTablePage() {
  //   Get.toNamed("/salesTable", arguments: {'salesData': filteredSales});
  // }
}
