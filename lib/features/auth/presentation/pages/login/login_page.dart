import 'package:al_amine_store/features/auth/presentation/pages/login/widgets/login_form.dart';
import 'package:al_amine_store/features/auth/presentation/pages/login/widgets/login_header.dart';
import 'package:al_amine_store/utlis/localaization/changelang.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<String>(
                        value: controller.isEnglish ? 'English' : 'العربية',
                        items: [
                          DropdownMenuItem(
                              value: 'English', child: Text('English')),
                          DropdownMenuItem(
                              value: 'العربية', child: Text('العربية')),
                        ],
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.changeLang(
                                newValue == 'English' ? "en" : "ar");
                          }
                        },
                      ),
                    ],
                  ),
                  LoginHeader(),
                  LoginForm(),
                ],
              )),
        ),
      ),
    );
  }
}
