import 'package:al_amine_store/features/home/presentation/widgets/app_primary_header_container.dart';
import 'package:al_amine_store/features/tables/controller/expenese_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ExpensesTable extends StatefulWidget {
  const ExpensesTable({super.key});

  @override
  State<ExpensesTable> createState() => _ExpensesTableState();
}

class _ExpensesTableState extends State<ExpensesTable> {
  ExpeneseTableControllerImpl controller =
      Get.put(ExpeneseTableControllerImpl());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Get.delete<ExpeneseTableControllerImpl>();
    });

    return Scaffold(
      body: Column(
        children: [
          AppPrimaryHeaderContainer(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoute.tablesPage);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultSpace, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: GetBuilder<ExpeneseTableControllerImpl>(
                          builder: (controller) {
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
                                const DropdownMenuItem(
                                  value: "all",
                                  child: Text("جميع المواقع"),
                                ),
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
                        icon: const Icon(
                          Iconsax.calendar_add,
                          color: AppColors.white,
                          size: 40,
                        ),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate:
                                controller.selectedDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now(),
                          );
                          if (pickedDate != null) {
                            controller.updateSelectedDate(pickedDate);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(
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
                const SizedBox(
                  height: AppSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
          // Wrap the GetBuilder in Expanded
          Expanded(
            child: GetBuilder<ExpeneseTableControllerImpl>(
              builder: (controller) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.filteredSales.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.defaultSpace, vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                            controller.filteredSales[index].salesItemName!),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
