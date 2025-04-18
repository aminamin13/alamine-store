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
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 600; // Tablet & Desktop
         
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? constraints.maxWidth * 0.25 : 24,
                  vertical: isWide ? 40 : 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton<String>(
                          value: controller.isEnglish ? 'English' : 'العربية',
                          items: [
                            const DropdownMenuItem(
                              value: 'English',
                              child: Text('English'),
                            ),
                            const DropdownMenuItem(
                              value: 'العربية',
                              child: Text('العربية'),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              controller.changeLang(
                                newValue == 'English' ? "en" : "ar",
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const LoginHeader(),
                    const LoginForm(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
