import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AppLoaders {
  static customToast(  {required message}) {
    
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          elevation: 0,
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppHelperFunctions.isDarkMode(Get.context!)
                  ? AppColors.darkerGrey.withOpacity(0.9)
                  : AppColors.grey.withOpacity(0.9),
            ), // BoxDecoration
            child: Center(
                child: Text(message,
                    style: Theme.of(Get.context!).textTheme.labelLarge)),
          ), // Container
        ), // SnackBar
      );
    }
  

  static successSnackBar({required title, message = "", duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: AppColors.success,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Iconsax.check, color: AppColors.white));
  }

  static warningSnackBar({required title, message = "", duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: AppColors.warning,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Iconsax.check, color: AppColors.white));
  }

  static errorSnackBar({required title, message = "", duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: AppColors.error,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Iconsax.check, color: AppColors.white));
  }
}
