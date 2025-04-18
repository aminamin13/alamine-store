import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/expenese/data/model/expenses_model.dart';
import 'package:al_amine_store/features/expenese/data/source/expenses_data_source.dart';
import 'package:al_amine_store/functions/handlingdatacontroller.dart';
import 'package:al_amine_store/loaders/snackbar.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpeneseControllerImpl extends GetxController
    with WidgetsBindingObserver {
  ExpensesModel? expensesModel;
  StatusRequest statusRequest = StatusRequest.none;
 
  List<ExpensesModel> expensesList = [];
  List<ExpensesModel> filteredExpenses = [];
  ExpensesDataSource expensesDataSource = ExpensesDataSource(Get.find());
  DateTime? selectedDate; // Default to null (no date selected)

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController noteController;
  late TextEditingController dateController;
  late TextEditingController priceController;

  var selectedValue = "محل خلدة";
  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("App resumed, refreshing UI");
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();

    viewExpenese();
    WidgetsBinding.instance.addObserver(this);

    nameController = TextEditingController();
    noteController = TextEditingController();
    dateController = TextEditingController();
    priceController = TextEditingController();
  }

  addExpeneses() async {
    var formdata = formKey.currentState;

    if (formdata!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      try {
        // Send the product data to the server using postData
        var response = await expensesDataSource.addData(
            name: nameController.text,
            location: selectedValue,
            note: noteController.text,
            price: AppValidator.convertArabicNumbers(
              priceController.text,
            ));
        statusRequest = handlingData(response);
        // Handling the response
        if (response['status'] == "success") {
          // Create the ProductModel with the response data
          expensesModel = ExpensesModel(
            name: nameController.text,
            location: selectedValue,
            note: noteController.text,
            price: int.parse(
                AppValidator.convertArabicNumbers(priceController.text)),
          );

          // Notify the UI and show success message
          AppLoaders.successSnackBar(title: "34".tr, message: "87".tr);
          // Clear form fields and images
          clearFields();
          statusRequest = StatusRequest.success;
          Get.offNamed(AppRoute.expenese);

          update();

          // Proceed with uploading images if any
        } else {
          // Handle any other status returned by the API
          statusRequest = StatusRequest.failure;
          AppLoaders.errorSnackBar(message: "88", title: "36".tr);
        }
      } catch (e) {
        print("Error: $e");
        statusRequest = StatusRequest.failure;
        AppLoaders.errorSnackBar(message: "89".tr, title: "36".tr);
      }
    }
  }

  void clearFilters() {
    selectedValue = "محل خلدة"; // Default location
    selectedDate = null; // Reset date filter
    applyFilter(); // Reapply filter with default values
    update();
  }

  viewExpenese() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await expensesDataSource.viewData();
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          List datalist = response['data'];

          expensesList =
              datalist.map((e) => ExpensesModel.fromJson(e)).toList();

          applyFilter(); // Apply filter after fetching data
        } else {
          statusRequest = StatusRequest.failure;
          AppLoaders.errorSnackBar(message: "89".tr, title: "36".tr);
        }
      }
    } catch (e) {
      print("Error fetching data: $e");
      statusRequest = StatusRequest.failure;
    }
  }

  deleteExpenese(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    try {
      var response = await expensesDataSource.deleteData(id);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          filteredExpenses
              .removeWhere((element) => element.id.toString() == id);
          AppLoaders.successSnackBar(title: "34".tr, message: "90".tr);
          update();
        } else {
          statusRequest = StatusRequest.failure;
          AppLoaders.errorSnackBar(message: "89".tr, title: "36".tr);
        }
      }
    } catch (e) {
      print("Error deleting data: $e");
      statusRequest = StatusRequest.failure;
    }
  }

  void applyFilter() {
    if (selectedValue == "all" && selectedDate == null) {
      filteredExpenses =
          List.from(expensesList); // Show all data when no filter is applied
    } else {
      filteredExpenses = expensesList.where((expenses) {
        bool locationMatch =
            selectedValue == "all" || expenses.location == selectedValue;
        bool dateMatch = selectedDate == null ||
            (expenses.date!.day == selectedDate!.day &&
                expenses.date!.month == selectedDate!.month &&
                expenses.date!.year == selectedDate!.year);
        return locationMatch && dateMatch;
      }).toList();
    }
    update(); // Update UI
  }

  void updateSelectedDate(DateTime? newDate) {
    selectedDate = newDate;
    applyFilter();
  }

  void clearFields() {
    nameController.clear();
    noteController.clear();
    dateController.clear();
    priceController.clear();
  }
}
