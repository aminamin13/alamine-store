import 'dart:io';

import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/products/controller/add_product_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:al_amine_store/utlis/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddAProductPage extends StatelessWidget {
  const AddAProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    AddProductControllerImp controller = Get.put(AddProductControllerImp());

    return Scaffold(
      appBar: AppBar(title: Text("16".tr)),
      body: GetBuilder<AddProductControllerImp>(
        builder: (_) {
          if (controller.statusRequest == StatusRequest.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.statusRequest == StatusRequest.failure) {
            return Center(child: Text("27".tr));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              bool isWide = constraints.maxWidth > 600;
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? constraints.maxWidth * 0.1 : 0,
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace,
                    vertical: 10,
                  ),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: controller.carTypeController,
                          validator:
                              (value) => AppValidator.validateEmptyText(
                                "17".tr,
                                value,
                              ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Iconsax.car),
                            labelText: "17".tr,
                            labelStyle: const TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 16,
                            ),
                            hintText: "28".tr,
                            hintStyle: const TextStyle(
                              color: AppColors.darkGrey,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwInputFields),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: controller.carYearController,
                                validator:
                                    (value) => AppValidator.validateNumber(
                                      "18".tr,
                                      value,
                                    ),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Iconsax.calendar_2),
                                  labelText: "18".tr,
                                  labelStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 16,
                                  ),
                                  hintText: "29".tr,
                                  hintStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSizes.spaceBtwItems),
                            Expanded(
                              child: TextFormField(
                                controller: controller.itemColorController,
                                validator:
                                    (value) => AppValidator.validateEmptyText(
                                      "19".tr,
                                      value,
                                    ),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Iconsax.color_swatch),
                                  labelText: "19".tr,
                                  labelStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 16,
                                  ),
                                  hintText: "30".tr,
                                  hintStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.spaceBtwInputFields),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: TextFormField(
                                controller: controller.itemNameController,
                                validator:
                                    (value) => AppValidator.validateEmptyText(
                                      "20".tr,
                                      value,
                                    ),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Iconsax.path_square),
                                  labelText: "20".tr,
                                  labelStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 16,
                                  ),
                                  hintText: "31".tr,
                                  hintStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSizes.spaceBtwItems),
                            Expanded(
                              child: TextFormField(
                                controller: controller.itemCountController,
                                keyboardType: TextInputType.number,
                                validator:
                                    (value) => AppValidator.validateEmptyText(
                                      "99".tr,
                                      value,
                                    ),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.numbers),
                                  labelText: "99".tr,
                                  labelStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 12,
                                  ),
                                  hintText: "100".tr,
                                  hintStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.spaceBtwInputFields),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Iconsax.location),
                            labelText: "21".tr,
                            labelStyle: const TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 16,
                            ),
                            hintStyle: const TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 12,
                            ),
                          ),
                          value: controller.selectedValue,
                          items: [
                            const DropdownMenuItem(
                              value: "بورة شوكين",
                              child: Text("بورة شوكين"),
                            ),
                            const DropdownMenuItem(
                              value: "محل دير الزهراني",
                              child: Text("محل دير الزهراني"),
                            ),
                            const DropdownMenuItem(
                              value: "بورة دير الزهراني",
                              child: Text("بورة دير الزهراني"),
                            ),
                            const DropdownMenuItem(
                              value: "محل خلدة",
                              child: Text("محل خلدة"),
                            ),
                          ],
                          onChanged: (value) {
                            controller.selectedValue = value!;
                          },
                        ),
                        const SizedBox(height: AppSizes.spaceBtwInputFields),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.itemPriceController,
                                validator:
                                    (value) => AppValidator.validateNumber(
                                      "22".tr,
                                      value,
                                    ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Iconsax.dollar_circle),
                                  labelText: "22".tr,
                                  labelStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 16,
                                  ),
                                  hintText: "22".tr,
                                  hintStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSizes.spaceBtwItems),
                            Expanded(
                              child: TextFormField(
                                controller: controller.itemSellPriceController,
                                validator:
                                    (value) => AppValidator.validateNumber(
                                      "23".tr,
                                      value,
                                    ),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Iconsax.dollar_circle),
                                  labelText: "23".tr,
                                  labelStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 12,
                                  ),
                                  hintText: "23".tr,
                                  hintStyle: const TextStyle(
                                    color: AppColors.darkGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: AppSizes.spaceBtwInputFields,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.spaceBtwInputFields),
                        TextFormField(
                          controller: controller.noteController,
                          maxLines: 3,
                          validator:
                              (value) => AppValidator.validateEmptyText(
                                "24".tr,
                                value,
                              ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Iconsax.note),
                            labelText: "24".tr,
                            labelStyle: const TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 16,
                            ),
                            hintText: "32".tr,
                            hintStyle: const TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwInputFields),
                        GetBuilder<AddProductControllerImp>(
                          builder: (controller) {
                            return controller.images.isNotEmpty
                                ? GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            3, // Display 3 images per row
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                      ),
                                  itemCount: controller.images.length,
                                  itemBuilder: (context, index) {
                                    return Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: Image.file(
                                            File(controller.images[index].path),
                                            fit: BoxFit.cover,
                                            height: 180,
                                            width: 300,
                                            cacheHeight: 400,
                                            cacheWidth: 400,
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 5,
                                          child: GestureDetector(
                                            onTap:
                                                () => controller.deleteImage(
                                                  index,
                                                ),
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                )
                                : const SizedBox();
                          },
                        ),
                        const SizedBox(height: AppSizes.spaceBtwInputFields),
                        ElevatedButton(
                          onPressed:
                              () => controller.pickMultipleImages(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.image,
                                size: 16,
                                color: AppColors.white,
                              ),
                              const SizedBox(width: 8),
                              Text("25".tr),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwInputFields),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.addProduct();
                            },
                            child: Text("26".tr),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
