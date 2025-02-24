import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:get/get.dart';

abstract class TableController extends GetxController {}

class TableControllerImpl extends TableController {
  void goToSalesTable() {
    try {
      Get.toNamed(AppRoute.salesTablePage);
    } catch (e) {
      Get.snackbar("Error", "Failed to navigate to the product page: $e");
    }
  }

  void goToExpensesTable() {
    try {
      Get.toNamed(AppRoute.expeneseTablePage);
    } catch (e) {
      Get.snackbar("Error", "Failed to navigate to the price list page: $e");
    }
  }
}
