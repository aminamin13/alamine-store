import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/home/presentation/widgets/app_primary_header_container.dart';
import 'package:al_amine_store/features/tables/controller/expenese_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ExpensesTable extends StatefulWidget {
  const ExpensesTable({super.key});

  @override
  State<ExpensesTable> createState() => _ExpensesTableState();
}

class _ExpensesTableState extends State<ExpensesTable>
    with WidgetsBindingObserver {
  late ExpeneseTableControllerImpl controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ExpeneseTableControllerImpl());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Get.delete<ExpeneseTableControllerImpl>();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.viewData(); // Refresh data when app is resumed
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

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
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth > 600 ? 50.0 : 20.0,
                    vertical: 10,
                  ),
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
                                  color: AppColors.darkGrey,
                                  fontSize: 16,
                                ),
                                hintStyle: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 12,
                                ),
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
                                ),
                              ],
                              onChanged: (value) {
                                controller.selectedValue = value!;
                                controller.applyFilter();
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
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
                const SizedBox(height: AppSizes.spaceBtwSections),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                alignment: Alignment.center,
                width: screenWidth > 600 ? double.infinity : 400,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GetBuilder<ExpeneseTableControllerImpl>(
                  builder: (controller) {
                    if (controller.statusRequest == StatusRequest.loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: screenWidth > 600 ? 600 : 300,
                        child: SfDataGrid(
                          columnWidthMode: ColumnWidthMode.fill,
                          selectionMode: SelectionMode.multiple,
                          footer: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Total Expeneses: ${controller.total} \$',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          source: controller.getExpenseDataSource(),
                          columns: controller.getColumns(
                            screenWidth > 600 ? 200 : 100,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
