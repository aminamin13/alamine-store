import 'package:al_amine_store/features/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashControllerImpl());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/store_logo.jpg'),
      ),
    );
  }
}
