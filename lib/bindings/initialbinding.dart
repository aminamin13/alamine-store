import 'package:al_amine_store/common/class/curd.dart';
import 'package:al_amine_store/features/price_list/controller/product_detail_controller.dart';
import 'package:al_amine_store/features/sales/controller/sales_controller.dart';
import 'package:al_amine_store/utlis/services/services.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(MyServices());
    Get.lazyPut(() => ProductDetailControllerImpl());
    Get.lazyPut(() => SalesControllerImpl());
  }
}
