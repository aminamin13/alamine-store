import 'package:al_amine_store/common/class/linkapi.dart';
import 'package:al_amine_store/common/widget/section_heading.dart';
import 'package:al_amine_store/features/price_list/controller/product_detail_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:al_amine_store/utlis/device/device_utility.dart';
import 'package:al_amine_store/utlis/validators/validation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProductDetailControllerImpl controller =
        Get.put(ProductDetailControllerImpl());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: GetBuilder<ProductDetailControllerImpl>(builder: (controller) {
          return SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Images Carousel
                if (controller.imagesList.isNotEmpty)
                  Center(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        enlargeCenterPage: false,
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: true,
                        viewportFraction: 0.8,
                      ),
                      items: controller.imagesList.map((image) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: CachedNetworkImage(
                              imageUrl:
                                  "${AppLink.imageitems}/${image.imageUrl}",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 300,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                  color: AppColors.primary,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error, color: Colors.red),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                SizedBox(height: 16),

                AppSectionHeading(title: "48".tr),
                SizedBox(height: 16),
                // Product name
                Row(
                  children: [
                    ProductTitleText(context, title: "49".tr),
                    Text(controller.productModel!.name!,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

                Row(
                  children: [
                    ProductTitleText(context, title: "51".tr),
                    Text(controller.productModel!.carType!,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

                Row(
                  children: [
                    ProductTitleText(context, title: "50".tr),
                    Text(controller.productModel!.year!.toString(),
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

                Row(
                  children: [
                    ProductTitleText(context, title: "52".tr),
                    Text(controller.productModel!.location!,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

                Row(
                  children: [
                    ProductTitleText(context, title: "53".tr),
                    Text(controller.productModel!.color!,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

                Row(
                  children: [
                    ProductTitleText(context, title: "54".tr),
                    Text("${controller.productModel!.price!.toString()}\$",
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 1.5),
                Row(
                  children: [
                    ProductTitleText(context, title: "55".tr),
                    Text("${controller.productModel!.sellPrice!.toString()}\$",
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 1.5),
                Row(
                  children: [
                    ProductTitleText(context, title: "101".tr),
                    Text(controller.productModel!.itemCount!.toString(),
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

                Row(
                  children: [
                    ProductTitleText(context, title: "56".tr),
                    Text(controller.productModel!.note!,
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),

                const SizedBox(height: AppSizes.spaceBtwItems / 1.5),
                controller.productModel!.itemCount! > 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          SizedBox(
                            width: AppDeviceUtils.getScreenWidth(context) / 3,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.error,
                                ),
                                onPressed: () async {
                                  //salesController.addSales();
                                  return showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("57".tr),
                                          content: SizedBox(
                                            width:
                                                400, // Adjust the width as needed
                                            height:
                                                250, // Adjust the height as needed
                                            child: Form(
                                              key: controller.formKey,
                                              child: Column(
                                                children: [
                                                  Text("58".tr),
                                                  const SizedBox(height: 10),
                                                  TextFormField(
                                                      controller: controller
                                                          .customerNameController,
                                                      validator: (value) =>
                                                          AppValidator
                                                              .validateEmptyText(
                                                                  "59".tr,
                                                                  value),
                                                      decoration:
                                                          InputDecoration(
                                                        prefixIcon: Icon(Iconsax
                                                            .color_swatch),
                                                        labelText: "59".tr,
                                                        labelStyle: TextStyle(
                                                            color: AppColors
                                                                .darkGrey,
                                                            fontSize: 16),
                                                        hintText: "60".tr,
                                                        hintStyle: TextStyle(
                                                            color: AppColors
                                                                .darkGrey,
                                                            fontSize: 12),
                                                      )),
                                                  const SizedBox(height: 10),
                                                  TextFormField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller: controller
                                                          .priceController,
                                                      validator: (value) =>
                                                          AppValidator
                                                              .validateEmptyText(
                                                                  "Item Price",
                                                                  value),
                                                      decoration:
                                                          InputDecoration(
                                                        prefixIcon: Icon(Iconsax
                                                            .dollar_circle),
                                                        labelText: "61".tr,
                                                        labelStyle: TextStyle(
                                                            color: AppColors
                                                                .darkGrey,
                                                            fontSize: 16),
                                                        hintText: "61".tr,
                                                        hintStyle: TextStyle(
                                                            color: AppColors
                                                                .darkGrey,
                                                            fontSize: 12),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              child: Text("62".tr),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButton(
                                              child: Text("63".tr),
                                              onPressed: () {
                                                controller.addSales();
                                              },
                                            ),
                                          ],
                                        );
                                      });
                                },
                                child: Text("64".tr)),
                          ),
                          SizedBox(
                            width: AppDeviceUtils.getScreenWidth(context) / 3,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
                                ),
                                onPressed: () {
                                  controller.goToProductEditPage();
                                },
                                child: Text("65".tr)),
                          ),
                          controller.globalSaleItemsId == null
                              ? IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                                title: Text("66".tr),
                                                content: Text("67".tr),
                                                actions: [
                                                  TextButton(
                                                    child: Text("62".tr),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  TextButton(
                                                      child: Text("68".tr),
                                                      onPressed: () {
                                                        Navigator.pop(context);

                                                        if (controller
                                                            .imagesList
                                                            .isEmpty) {
                                                          controller.deleteData(
                                                              imageName: "",
                                                              itemId: controller
                                                                  .productModel!
                                                                  .id
                                                                  .toString());
                                                        } else {
                                                          for (var image
                                                              in controller
                                                                  .imagesList) {
                                                            if (image.itemsId ==
                                                                controller
                                                                    .productModel!
                                                                    .id) {
                                                              if (image
                                                                      .imageUrl !=
                                                                  null) {
                                                                controller
                                                                    .deleteData(
                                                                  imageName: image
                                                                      .imageUrl!,
                                                                  itemId: controller
                                                                      .productModel!
                                                                      .id
                                                                      .toString(),
                                                                );
                                                              } else {
                                                                print(
                                                                    "Error: imageUrl is null for product ${controller.productModel!.id}");
                                                              }
                                                            }
                                                          }
                                                        }
                                                      })
                                                ]));
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors.error,
                                  ))
                              : SizedBox(),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          SizedBox(
                            width: AppDeviceUtils.getScreenWidth(context) / 3,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
                                ),
                                onPressed: () {
                                  controller.goToProductEditPage();
                                },
                                child: Text("65".tr)),
                          ),
                          controller.globalSaleItemsId == null
                              ? IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                                title: Text("66".tr),
                                                content: Text("67".tr),
                                                actions: [
                                                  TextButton(
                                                    child: Text("62".tr),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  TextButton(
                                                      child: Text("68".tr),
                                                      onPressed: () {
                                                        Navigator.pop(context);

                                                        if (controller
                                                            .imagesList
                                                            .isEmpty) {
                                                          controller.deleteData(
                                                              imageName: "",
                                                              itemId: controller
                                                                  .productModel!
                                                                  .id
                                                                  .toString());
                                                        } else {
                                                          for (var image
                                                              in controller
                                                                  .imagesList) {
                                                            if (image.itemsId ==
                                                                controller
                                                                    .productModel!
                                                                    .id) {
                                                              if (image
                                                                      .imageUrl !=
                                                                  null) {
                                                                controller
                                                                    .deleteData(
                                                                  imageName: image
                                                                      .imageUrl!,
                                                                  itemId: controller
                                                                      .productModel!
                                                                      .id
                                                                      .toString(),
                                                                );
                                                              } else {
                                                                print(
                                                                    "Error: imageUrl is null for product ${controller.productModel!.id}");
                                                              }
                                                            }
                                                          }
                                                        }
                                                      })
                                                ]));
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors.error,
                                  ))
                              : SizedBox(),
                        ],
                      )
              ],
            ),
          ));
        }));
  }

  Widget ProductTitleText(
    BuildContext context, {
    required String title,
  }) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleSmall!
          .copyWith(fontWeight: FontWeight.bold),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
    );
  }
}
