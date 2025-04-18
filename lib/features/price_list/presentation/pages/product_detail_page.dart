import 'package:al_amine_store/common/class/linkapi.dart';
import 'package:al_amine_store/features/price_list/controller/product_detail_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductDetailControllerImpl controller = Get.put(
      ProductDetailControllerImpl(),
    );

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: GetBuilder<ProductDetailControllerImpl>(
        builder: (controller) {
          return LayoutBuilder(
            builder: (context, constraints) {
              bool isLargeScreen = constraints.maxWidth > 600;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child:
                    isLargeScreen
                        ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image Section (Left)
                            Expanded(
                              flex: 2,
                              child:
                                  controller.imagesList.isNotEmpty
                                      ? buildImageCarousel(controller)
                                      : const SizedBox(height: 300),
                            ),
                            const SizedBox(width: 24),
                            // Details Section (Right)
                            Expanded(
                              flex: 3,
                              child: buildProductDetails(context, controller),
                            ),
                          ],
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image Section (Full Width)
                            if (controller.imagesList.isNotEmpty)
                              buildImageCarousel(controller),
                            const SizedBox(height: 16),
                            // Product Details
                            buildProductDetails(context, controller),
                          ],
                        ),
              );
            },
          );
        },
      ),
    );
  }

  /// Image Carousel Widget
  Widget buildImageCarousel(ProductDetailControllerImpl controller) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 300,
          enlargeCenterPage: false,
          aspectRatio: 16 / 9,
          enableInfiniteScroll: true,
          viewportFraction: 0.8,
        ),
        items:
            controller.imagesList.map((image) {
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
                    imageUrl: "${AppLink.imageitems}/${image.imageUrl}",
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
                    errorWidget:
                        (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  /// Product Details Widget
  Widget buildProductDetails(
    BuildContext context,
    ProductDetailControllerImpl controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDetailRow(context, "48".tr, controller.productModel?.name),
        buildDetailRow(context, "51".tr, controller.productModel?.carType),
        buildDetailRow(
          context,
          "50".tr,
          controller.productModel?.year?.toString(),
        ),
        buildDetailRow(context, "52".tr, controller.productModel?.location),
        buildDetailRow(context, "53".tr, controller.productModel?.color),
        buildDetailRow(
          context,
          "54".tr,
          "${controller.productModel?.price ?? 0}\$",
        ),
        buildDetailRow(
          context,
          "55".tr,
          "${controller.productModel?.sellPrice ?? 0}\$",
        ),
        buildDetailRow(
          context,
          "101".tr,
          controller.productModel?.itemCount?.toString(),
        ),
        buildDetailRow(context, "56".tr, controller.productModel?.note),

        const SizedBox(height: AppSizes.spaceBtwItems / 1.5),

        // Action Buttons
        if (controller.productModel!.itemCount! > 0)
          buildActionButtons(context, controller),
      ],
    );
  }

  /// Helper Function to Build a Row for Product Details
  Widget buildDetailRow(BuildContext context, String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          ProductTitleText(context, title: title),
          const SizedBox(width: 8),
          Text(value ?? "N/A", style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  /// Action Buttons for Editing or Deleting Products
  Widget buildActionButtons(
    BuildContext context,
    ProductDetailControllerImpl controller,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Sell Button
        SizedBox(
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => showSaleDialog(context, controller),
            child: Text("64".tr),
          ),
        ),
        const SizedBox(width: 15),
        // Edit Button
        SizedBox(
          width: 150,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
            onPressed: controller.goToProductEditPage,
            child: Text("65".tr),
          ),
        ),
      ],
    );
  }

  /// Show Dialog for Selling Product
  void showSaleDialog(
    BuildContext context,
    ProductDetailControllerImpl controller,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("57".tr),
            content: Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("58".tr),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: controller.customerNameController,
                    validator:
                        (value) =>
                            value == null || value.isEmpty ? "59".tr : null,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      labelText: "59".tr,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: controller.priceController,
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Item Price"
                                : null,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.attach_money),
                      labelText: "61".tr,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text("62".tr),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(onPressed: controller.addSales, child: Text("63".tr)),
            ],
          ),
    );
  }

  /// Product Title Text Widget
  Widget ProductTitleText(BuildContext context, {required String title}) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.left,
    );
  }
}
