import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/expenese/controller/expenese_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:al_amine_store/utlis/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ExpeneseAddPage extends StatelessWidget {
  const ExpeneseAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    ExpeneseControllerImpl controller = Get.put(ExpeneseControllerImpl());

    return Scaffold(
      appBar: AppBar(
        title: Text("78".tr),
      ),
      body: GetBuilder<ExpeneseControllerImpl>(builder: (_) {
        if (controller.statusRequest == StatusRequest.loading) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.statusRequest == StatusRequest.failure) {
          return Center(child: Text("37".tr));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.defaultSpace, vertical: 10),
          child: Form(
            key: controller.formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextFormField(
                  controller: controller.nameController,
                  validator: (value) =>
                      AppValidator.validateEmptyText("79".tr, value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.car),
                    labelText: "79".tr,
                    labelStyle:
                        TextStyle(color: AppColors.darkGrey, fontSize: 16),
                    hintText: "80".tr,
                    hintStyle: TextStyle(color: AppColors.darkGrey),
                  )),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.priceController,
                  validator: (value) =>
                      AppValidator.validateNumber("81".tr, value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.calendar_2),
                    labelText: "81".tr,
                    labelStyle:
                        TextStyle(color: AppColors.darkGrey, fontSize: 16),
                    hintText: "81".tr,
                    hintStyle:
                        TextStyle(color: AppColors.darkGrey, fontSize: 12),
                  )),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.location),
                  labelText: "82".tr,
                  labelStyle:
                      TextStyle(color: AppColors.darkGrey, fontSize: 16),
                  hintStyle: TextStyle(color: AppColors.darkGrey, fontSize: 12),
                ),
                value: controller.selectedValue,
                items: [
                  DropdownMenuItem(
                    value: "بورة شوكين",
                    child: Text("بورة شوكين"),
                  ),
                  DropdownMenuItem(
                    value: "محل دير الزهراني",
                    child: Text("محل دير الزهراني"),
                  ),
                  DropdownMenuItem(
                    value: "بورة دير الزهراني",
                    child: Text("بورة دير الزهراني"),
                  ),
                  DropdownMenuItem(
                    value: "محل خلدة",
                    child: Text("محل خلدة"),
                  )
                ],
                onChanged: (value) {
                  controller.selectedValue = value!;
                },
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              TextFormField(
                  controller: controller.noteController,
                  maxLines: 3,
                  validator: (value) =>
                      AppValidator.validateEmptyText("83".tr, value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.note),
                    labelText: "83".tr,
                    labelStyle:
                        TextStyle(color: AppColors.darkGrey, fontSize: 16),
                    hintText: "84".tr,
                    hintStyle: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 12,
                    ),
                  )),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.addExpeneses();
                    },
                    child: Text("85".tr)),
              ),
            ]),
          ),
        );
      }),
    );
  }
}
