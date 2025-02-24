import 'package:al_amine_store/features/auth/controller/signin_controller.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:al_amine_store/utlis/helpers/helpers_function.dart';
import 'package:al_amine_store/utlis/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);

    SigninControllerImpl controller = Get.put(SigninControllerImpl());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: [
            // email

            TextFormField(
                controller: controller.emailController,
                validator: (value) {
                  return AppValidator.validateEmptyText("Email", value);
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: "3".tr,
                )),
            const SizedBox(
              height: AppSizes.spaceBtwInputFields,
            ),
            GetBuilder<SigninControllerImpl>(
              builder: (_) {
                return TextFormField(
                    controller: controller.passwordController,
                    validator: (value) {
                      return AppValidator.validateEmptyText('password', value);
                    },
                    obscureText: controller.isShowPassword,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Iconsax.password_check),
                        labelText: "4".tr,
                        suffixIcon: IconButton(
                          icon: Icon(controller.isShowPassword
                              ? Iconsax.eye_slash
                              : Iconsax.eye),
                          onPressed: () {
                            controller.showPassword();
                          },
                        )));
              },
            ),
            const SizedBox(
              height: AppSizes.spaceBtwInputFields / 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {}, child: Text("5".tr)),
              ],
            ),
            const SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    controller.signIn();
                  },
                  child: Text("6".tr)),
            ),
            const SizedBox(
              height: AppSizes.spaceBtwItems,
            ),
          ],
        ),
      ),
    );
  }
}
