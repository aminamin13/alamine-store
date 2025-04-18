import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/expenese/controller/expenese_controller.dart';
import 'package:al_amine_store/features/home/presentation/widgets/app_primary_header_container.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    ExpeneseControllerImpl controller = Get.put(ExpeneseControllerImpl());

    Future.delayed(Duration.zero, () {
      Get.delete<ExpeneseControllerImpl>();
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(
          Iconsax.add,
          color: Colors.white,
        ),
        onPressed: () {
          Get.toNamed(AppRoute.addExpenese);
        },
      ),
      body: Column(children: [
        AppPrimaryHeaderContainer(
            child: Column(children: [
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
                Get.toNamed(AppRoute.homePage);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultSpace, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: GetBuilder<ExpeneseControllerImpl>(
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
        ])),
        GetBuilder<ExpeneseControllerImpl>(
          builder: (controller) {
            if (controller.statusRequest == StatusRequest.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.statusRequest == StatusRequest.failure) {
              return Center(child: Text("27".tr));
            } else if (controller.filteredExpenses.isEmpty) {
              return Center(
                  child: Text("${"75".tr} ${controller.selectedValue}"));
            }
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: controller.filteredExpenses.length,
                itemBuilder: (context, index) {
                  final expense = controller.filteredExpenses[index];

                  // Debugging each item
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
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
                              print("Expense ID: ${expense.id}");

                              controller.deleteExpenese(expense.id!.toString());
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
                          expense.name ?? "Unnamed Product",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${expense.note}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${expense.note}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "${"76".tr} ${expense.date!.day}-${expense.date!.month}-${expense.date!.year}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        trailing: Text(
                          "${"77".tr} ${expense.price}\$",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
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
