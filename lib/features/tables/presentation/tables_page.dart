import 'package:al_amine_store/features/home/presentation/widgets/app_primary_header_container.dart';
import 'package:al_amine_store/features/tables/controller/table_controller.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({
    super.key,
  });
  //final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    TableControllerImpl homeController = Get.put(TableControllerImpl());

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          AppPrimaryHeaderContainer(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    Get.toNamed(AppRoute.homePage);
                  },
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: AppSizes.defaultSpace,
                  right: AppSizes.defaultSpace,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ],
          )),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 100,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ButtonContainer(
                        title: "144".tr,
                        icon: Icons.attach_money,
                        onTap: () => homeController.goToSalesTable(),
                      ),
                      ButtonContainer(
                        title: "145".tr,
                        icon: Icons.money_off,
                        onTap: () => homeController.goToExpensesTable(),
                      ),
                    ])
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class ButtonContainer extends StatelessWidget {
  const ButtonContainer(
      {super.key, required this.title, this.onTap, required this.icon});

  final String title;
  final void Function()? onTap;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.4, // 40% of screen width
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(
              icon,
              size: 45,
              color: AppColors.grey,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
