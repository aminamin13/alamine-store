import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/common/widget/search_textfield.dart';
import 'package:al_amine_store/features/home/presentation/widgets/app_primary_header_container.dart';
import 'package:al_amine_store/features/price_list/controller/price_list_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceListPage extends StatelessWidget {
  const PriceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    PriceListControllerImpl controller =
        Get.put(PriceListControllerImpl()); // Ensuring permanent controller

    Future.delayed(Duration.zero, () {
      Get.delete<PriceListControllerImpl>();
    });
    return Scaffold(
        body: Column(
      children: [
        AppPrimaryHeaderContainer(
          child: Column(children: [
            AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              elevation: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.toNamed(AppRoute.homePage);
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    left: AppSizes.defaultSpace,
                    right: AppSizes.defaultSpace,
                    bottom: AppSizes.defaultSpace),
                child: GetBuilder<PriceListControllerImpl>(
                  builder: (_) {
                    return Text("${"47".tr}: ${controller.allProducts.length}",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.white));
                  },
                )),
            GetBuilder<PriceListControllerImpl>(
              builder: (_) {
                return AppSearchTextField(
                  text: "8".tr,
                  controller: _.searchController,
                  onChanged: (query) => _.search(query),
                );
              },
            ),
            SizedBox(
              height: AppSizes.spaceBtwSections,
            ),
          ]),
        ),
        GetBuilder<PriceListControllerImpl>(
          builder: (controller) {
            if (controller.statusRequest == StatusRequest.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.statusRequest == StatusRequest.failure) {
              return Center(child: Text("27".tr));
            } else if (controller.allProducts.isEmpty) {
              return Center(child: Text("42".tr));
            }
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = controller.filteredProducts[index];
                  //final images = controller.images[index];

                  print(
                      "Building item: ${product.name}"); // Debugging each item
                  return Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        controller
                            .goToProductDetails(controller.allProducts[index]);
                      },
                      child: ListTile(
                        title: Row(
                          spacing: 15,
                          children: [
                            Text(
                              product.name ?? "Unnamed Product",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              product.itemCount.toString() ?? "1",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product.carType} ${product.year}" ??
                                  "Unnamed Product",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                          ],
                        ),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${"45".tr}: ${product.price}\$",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            Text(
                              "${"46".tr}: ${product.sellPrice}\$",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    ));
  }
}
