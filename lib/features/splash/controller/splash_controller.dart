import 'package:al_amine_store/utlis/services/services.dart';
import 'package:get/get.dart';

abstract class SplashController extends GetxController {}

class SplashControllerImpl extends SplashController {
  MyServices myServices = Get.find();

  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(const Duration(seconds: 2), () {
      myServices.sharedPreferences.setString("step", "1");

      Get.offAndToNamed("/login");
    });

    super.onInit();
  }
}
