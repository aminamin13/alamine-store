import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/services/services.dart';
import 'package:get/get.dart';

abstract class HomeController extends GetxController {}

class HomeControllerImpl extends HomeController {
  final MyServices myServices = Get.find();

  final RxString name = ''.obs;
  final RxInt id = 0.obs;
  final Rx<StatusRequest> statusRequest = StatusRequest.none.obs;

  void goToProductPage() {
    try {
      Get.toNamed(AppRoute.addAProductPage);
    } catch (e) {
      Get.snackbar("Error", "Failed to navigate to the product page: $e");
    }
  }

  void goToPriceListPage() {
    try {
      Get.toNamed(AppRoute.priceListPage);
    } catch (e) {
      Get.snackbar("Error", "Failed to navigate to the price list page: $e");
    }
  }

  void goToSalesPage() {
    try {
      Get.toNamed(AppRoute.sales);
    } catch (e) {
      Get.snackbar("Error", "Failed to navigate to the sales page: $e");
    }
  }

  void goToExpnesesPage() {
    try {
      Get.toNamed(AppRoute.expenese);
    } catch (e) {
      Get.snackbar("Error", "Failed to navigate to the expense page: $e");
    }
  }

  void goToTablePage() {
    try {
      Get.toNamed(AppRoute.tablesPage);
    } catch (e) {
      Get.snackbar(
          "Error", "Failed to navigate to the salesTablePage page: $e");
    }
  }

  void initialData() {
    name.value = myServices.sharedPreferences.getString("name") ?? '';
    id.value = myServices.sharedPreferences.getInt("id") ?? 0;
    print("Initialized user data: name=$name, id=$id");
  }

  void logout() {
    myServices.sharedPreferences.clear();
    Get.offAllNamed(AppRoute.loginPage);
  }

  @override
  void onReady() {
    super.onReady();
    initialData();
  }
}
