import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/home/presentation/widgets/app_primary_header_container.dart';
import 'package:al_amine_store/features/sales/controller/sales_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    SalesControllerImpl controller = Get.put(SalesControllerImpl());

    Future.delayed(Duration.zero, () {
      Get.delete<SalesControllerImpl>();
    });
    return Scaffold(
      body: Column(children: [
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
            padding: EdgeInsets.symmetric(
                horizontal: AppSizes.defaultSpace, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: GetBuilder<SalesControllerImpl>(
                    initState: (_) {},
                    builder: (_) {
                      return DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.location),
                          filled: true,
                          labelStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 16),
                          hintStyle: TextStyle(
                              color: AppColors.darkGrey, fontSize: 12),
                        ),
                        value: controller.selectedValue,
                        items: [
                          DropdownMenuItem(
                            value: "all",
                            child: Text("جميع المواقع"),
                          ),
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
                          controller.applyFilter();
                        },
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Iconsax.calendar_add,
                    color: AppColors.white,
                    size: 40,
                  ),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: controller.selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      controller.updateSelectedDate(pickedDate);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    Iconsax.refresh,
                    color: AppColors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    controller.clearFilters();
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: AppSizes.spaceBtwSections,
          ),
        ])),
        GetBuilder<SalesControllerImpl>(
          builder: (controller) {
            if (controller.statusRequest == StatusRequest.loading) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.statusRequest == StatusRequest.failure) {
              return Center(child: Text("37".tr));
            } else if (controller.filteredSales.isEmpty) {
              return Center(
                  child: Text("${"70".tr} ${controller.selectedValue}"));
            }
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: controller.filteredSales.length,
                itemBuilder: (context, index) {
                  final sales = controller.filteredSales[index];
                  // Debugging each item
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
                        // controller
                        //     .goToProductDetails(controller.allProducts[index]);
                      },
                      child: Slidable(
                        startActionPane: ActionPane(
                          // A motion is a widget used to control how the pane animates.
                          motion: const ScrollMotion(),
                          dragDismissible: false,
                          extentRatio: 0.25,
                          // A pane can dismiss the Slidable.
                          dismissible: DismissiblePane(onDismissed: () {}),
                          key: const ValueKey(0),

                          // All actions are defined in the children parameter.
                          children: [
                            // A SlidableAction can have an icon and/or a label.
                            SlidableAction(
                              onPressed: (context) {
                                controller.deleteData(
                                  controller.filteredSales[index].salesId
                                      .toString(),
                                );
                                controller.editItemCountNumber(controller
                                    .filteredSales[index].itemsId
                                    .toString());
                              },
                              backgroundColor: AppColors.error,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: '68'.tr,
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            sales.salesItemName ?? "Unnamed Product",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${sales.salesItemCarType} ${sales.salesItemYear}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${"71".tr} ${sales.salesCustomer}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${"72".tr} ${sales.salesDate!.day}-${sales.salesDate!.month}-${sales.salesDate!.year}",
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
                                "${"73".tr}  ${sales.salesPrice}\$",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                "${"74".tr}  ${sales.salesProfit}\$",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: sales.salesProfit! > 0
                                        ? Colors.green
                                        : Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
      ]),
    );
  }
}
