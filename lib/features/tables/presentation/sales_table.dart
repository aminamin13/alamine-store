import 'package:al_amine_store/common/class/status_request.dart';
import 'package:al_amine_store/features/home/presentation/widgets/app_primary_header_container.dart';
import 'package:al_amine_store/features/tables/controller/sales_table_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class SalesTable extends StatefulWidget {
  const SalesTable({super.key});

  @override
  State<SalesTable> createState() => _SalesTableState();
}

class _SalesTableState extends State<SalesTable> {
  SalesTableControllerImp controller = Get.put(SalesTableControllerImp());

  // late List<Employee> _employees;
  // late EmployeeDataSource _employeeDataSource;

  // @override
  // initState() {
  //   _employees = getEmployeeData();
  //   _employeeDataSource = EmployeeDataSource(_employees);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Get.delete<SalesTableControllerImp>();
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
                        child: GetBuilder<SalesTableControllerImp>(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: GetBuilder<SalesTableControllerImp>(
                builder: (controller) => controller.statusRequest ==
                        StatusRequest.loading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SfDataGrid(
                        columnWidthMode: ColumnWidthMode.fitByColumnName,
                        selectionMode: SelectionMode.multiple,
                        //allowFiltering: true,
                        footer: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Total: ${controller.total}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        source: controller.getSalesDataSource(),
                        columns: controller.getColumns(),
                      )),
          )
        ],
      ),
    );
  }
}

//  // SizedBox(
//         //     height: 600,
//         //     child: SfDataGrid(
//         //       footer: Container(
//         //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         //         alignment: Alignment.centerRight,
//         //         child: Text(
//         //           'Total: 50',
//         //           style: TextStyle(fontWeight: FontWeight.bold),
//         //         ),
//         //       ),
//         //       rowHeight: 50,
//         //       columnWidthMode: ColumnWidthMode.fill,
//         //       source: _employeeDataSource,
//         //       allowSorting: true,
//         //       selectionMode: SelectionMode.multiple,
//         //       columns: [
//         //         GridColumn(
//         //           columnName: 'id',
//         //           label: Container(
//         //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         //               alignment: Alignment.centerLeft,
//         //               child: Text(
//         //                 'ID',
//         //                 overflow: TextOverflow.ellipsis,
//         //               )),
//         //         ),
//         //         GridColumn(
//         //           columnName: 'name',
//         //           label: Container(
//         //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         //               alignment: Alignment.centerLeft,
//         //               child: Text(
//         //                 'Name',
//         //                 overflow: TextOverflow.ellipsis,
//         //               )),
//         //         ),
//         //         GridColumn(
//         //           columnName: 'email',
//         //           label: Container(
//         //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         //               alignment: Alignment.centerLeft,
//         //               child: Text(
//         //                 'Email',
//         //                 overflow: TextOverflow.ellipsis,
//         //               )),
//         //         ),
//         //         GridColumn(
//         //           columnName: 'salary',
//         //           label: Container(
//         //               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         //               alignment: Alignment.centerLeft,
//         //               child: Text(
//         //                 'Salary',
//         //                 overflow: TextOverflow.ellipsis,
//         //               )),
//         //         ),
//         //       ],
//         //     ),
//         //   ),

//   List<Employee> getEmployeeData() {
//     return [
//       Employee(1, "John Doe", "h6EYs@example.com", 5000),
//       Employee(2, "Jane Smith", "h6EYs@example.com", 6000),
//       Employee(3, "Alice Johnson", "h6EYs@example.com", 7000),
//       Employee(4, "Bob Williams", "h6EYs@example.com", 8000),
//       Employee(5, "Eve Brown", "h6EYs@example.com", 9000),
//       Employee(6, "Charlie Davis", "h6EYs@example.com", 10000),
//       Employee(7, "Frank Wilson", "h6EYs@example.com", 11000),
//       Employee(8, "Grace Moore", "h6EYs@example.com", 12000),
//       Employee(9, "Hank Thompson", "h6EYs@example.com", 13000),
//       Employee(10, "Ivy Anderson", "h6EYs@example.com", 14000),
//       Employee(11, "Jack Jackson", "h6EYs@example.com", 15000),
//       Employee(12, "Katie Thompson", "h6EYs@example.com", 16000),
//       Employee(13, "Liam Davis", "h6EYs@example.com", 17000),
//       Employee(14, "Mia Wilson", "h6EYs@example.com", 18000),
//       Employee(15, "Noah Anderson", "h6EYs@example.com", 19000),
//       Employee(16, "Olivia Jackson", "h6EYs@example.com", 20000),
//       Employee(17, "Parker Thompson", "h6EYs@example.com", 21000),
//       Employee(18, "Quinn Davis", "h6EYs@example.com", 22000),
//       Employee(19, "Riley Wilson", "h6EYs@example.com", 23000),
//       Employee(20, "Sophia Anderson", "h6EYs@example.com", 24000),
//     ];
//   }
// }

// class EmployeeDataSource extends DataGridSource {
//   EmployeeDataSource(List<Employee> employees) {
//     dataGridRows = employees
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<int>(columnName: "id", value: e.id),
//               DataGridCell<String>(columnName: "name", value: e.name),
//               DataGridCell<String>(columnName: "email", value: e.email),
//               DataGridCell<int>(columnName: "sallary", value: e.sallary),
//             ]))
//         .toList();
//   }

//   late List<DataGridRow> dataGridRows;

//   @override
//   List<DataGridRow> get rows => dataGridRows;

//   @override
//   DataGridRowAdapter? buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row
//             .getCells()
//             .map<Widget>((e) => Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 alignment: (e.columnName == "id" || e.columnName == "salary")
//                     ? Alignment.centerRight
//                     : Alignment.centerLeft,
//                 child: Text(
//                   e.value.toString(),
//                   overflow: TextOverflow.ellipsis,
//                 )))
//             .toList());
//   }
// }

// class Employee {
//   final int id;
//   final String name;
//   final String email;
//   final int sallary;

//   Employee(this.id, this.name, this.email, this.sallary);
// }
