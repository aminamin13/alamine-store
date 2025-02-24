import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/auth/data/datasource/remote/signin_data.dart';
import 'package:al_amine_store/functions/handlingdatacontroller.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SigninController extends GetxController {
  signIn();
  showPassword();
}

class SigninControllerImpl extends SigninController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isShowPassword = true;

  StatusRequest statusRequest = StatusRequest.none;

  SigninData signinData = SigninData(Get.find());
  MyServices myServices = Get.find();

  late int usersid;
  late String name;
  //late UserModel user;

  @override
  showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  signIn() async {
    var formValid = formKey.currentState!;

    if (formValid.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      var response = await signinData.postData(
          emailController.text, passwordController.text);
      statusRequest = handlingData(response);
      if (response['status'] == "success") {
        print(response);
        myServices.sharedPreferences.setInt("id", response['data']['users_id']);
        usersid = myServices.sharedPreferences.getInt("id")!;
        myServices.sharedPreferences
            .setString("name", response['data']['users_name']);

        name = myServices.sharedPreferences.getString("name")!;
        myServices.sharedPreferences
            .setString("username", response['data']['users_username']);
        myServices.sharedPreferences.setString("step", "2");
        print("____________________$name");
        print("____________________$usersid");

        // Redirect to HomePage with user data
        Get.offAllNamed(AppRoute.homePage,
            arguments: {"id": usersid, "name": name} //,arguments: user}
            );
      } else {
        Get.defaultDialog(
            title: "40".tr,
            middleText: "86".tr,);
        statusRequest = StatusRequest.failure;
      }

      update();
    } else {
      print("Form is not valid");
    }
  }

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
