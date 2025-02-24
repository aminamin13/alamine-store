import 'package:al_amine_store/features/price_list/controller/edit_product_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:al_amine_store/utlis/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class EditProductDetailPage extends StatelessWidget {
  const EditProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    EditProductControllerImp controller = Get.put(EditProductControllerImp());

    return Scaffold(
      appBar: AppBar(
        title: Text("69".tr),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.defaultSpace, vertical: 10),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  controller: controller.carTypeController,
                  validator: (value) =>
                      AppValidator.validateEmptyText("17".tr, value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.car),
                    labelText: "17".tr,
                    labelStyle:
                        TextStyle(color: AppColors.darkGrey, fontSize: 16),
                    hintText: "28".tr,
                    hintStyle: TextStyle(color: AppColors.darkGrey),
                  )),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controller.carYearController,
                        validator: (value) =>
                            AppValidator.validateNumber("18".tr, value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.calendar_2),
                          labelText: "18".tr,
                          labelStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 16),
                          hintText: "29".tr,
                          hintStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 12),
                        )),
                  ),
                  const SizedBox(
                    width: AppSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: TextFormField(
                        controller: controller.itemColorController,
                        validator: (value) =>
                            AppValidator.validateEmptyText("19".tr, value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.color_swatch),
                          labelText: "19".tr,
                          labelStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 16),
                          hintText: "30".tr,
                          hintStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 12),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                        controller: controller.itemNameController,
                        validator: (value) =>
                            AppValidator.validateEmptyText("20".tr, value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.path_square),
                          labelText: "20".tr,
                          labelStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 16),
                          hintText: "31".tr,
                          hintStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 12),
                        )),
                  ),
                  Expanded(
                    child: TextFormField(
                        controller: controller.itemCountController,
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            AppValidator.validateEmptyText("99".tr, value),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.numbers),
                          labelText: "99".tr,
                          labelStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 12),
                          hintText: "100".tr,
                          hintStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 12),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.location),
                  labelText: "21".tr,
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
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        controller: controller.itemPriceController,
                        validator: (value) =>
                            AppValidator.validateNumber("22".tr, value),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.dollar_circle),
                          labelText: "22".tr,
                          labelStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 16),
                          hintText: "22".tr,
                          hintStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 12),
                        )),
                  ),
                  const SizedBox(
                    width: AppSizes.spaceBtwItems,
                  ),
                  Expanded(
                    child: TextFormField(
                        controller: controller.itemSellPriceController,
                        validator: (value) =>
                            AppValidator.validateNumber("23".tr, value),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Iconsax.dollar_circle),
                          labelText: "23".tr,
                          labelStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 12),
                          hintText: "23".tr,
                          hintStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 12),
                        )),
                  ),
                  const SizedBox(
                    height: AppSizes.spaceBtwInputFields,
                  ),
                ],
              ),
              const SizedBox(
                height: AppSizes.spaceBtwInputFields,
              ),
              TextFormField(
                  controller: controller.noteController,
                  maxLines: 3,
                  validator: (value) =>
                      AppValidator.validateEmptyText("24".tr, value),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Iconsax.note),
                    labelText: "24".tr,
                    labelStyle:
                        TextStyle(color: AppColors.darkGrey, fontSize: 16),
                    hintText: "32".tr,
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
                      controller.editProduct();
                    },
                    child: Text("69".tr)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 // ElevatedButton(
              //   onPressed: () => controller.pickMultipleImages(context),
              //   child: Row(
              //     spacing: 10,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: const [
              //       Icon(
              //         Icons.image,
              //         size: 16,
              //         color: AppColors.white,
              //       ),
              //       Text("Add Image"),
              //     ],
              //   ),
              // ),
              // const SizedBox(
              //   height: AppSizes.spaceBtwInputFields,
              // ),
              // GetBuilder<EditProductControllerImp>(
              //   builder: (controller) {
              //     return controller.imagesList.isNotEmpty
              //         ? GridView.builder(
              //             shrinkWrap: true,
              //             physics: NeverScrollableScrollPhysics(),
              //             gridDelegate:
              //                 const SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 3, // Display 3 imagesList per row
              //               crossAxisSpacing: 10,
              //               mainAxisSpacing: 10,
              //             ),
              //             itemCount: controller.isFileImage == true
              //                 ? controller.images.length
              //                 : controller.imagesList.length,
              //             itemBuilder: (context, index) {
              //               return Stack(
              //                 children: [
              //                   controller.isFileImage == true
              //                       ? Image.file(
              //                           File(controller.images[index].path),
              //                           fit: BoxFit.fill,
              //                           height: 180,
              //                           width: 300,
              //                         )
              //                       : ClipRRect(
              //                           borderRadius: BorderRadius.circular(16),
              //                           child: Image.network(
              //                             "${AppLink.imageitems}/${controller.imagesList[index].imageUrl}",
              //                             fit: BoxFit.fill,
              //                             height: 180,
              //                             width: 300,
              //                           ),
              //                         ),
              //                   Positioned(
              //                     top: 5,
              //                     right: 5,
              //                     child: GestureDetector(
              //                       onTap: () => controller.deleteImage(index),
              //                       child: Container(
              //                         padding: EdgeInsets.all(5),
              //                         decoration: BoxDecoration(
              //                           color: Colors.red,
              //                           shape: BoxShape.circle,
              //                         ),
              //                         child: Icon(
              //                           Icons.close,
              //                           color: Colors.white,
              //                           size: 16,
              //                         ),
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               );
              //             },
              //           )
              //         : SizedBox();
              //   },
              // ),