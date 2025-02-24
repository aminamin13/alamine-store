import 'package:al_amine_store/common/widget/search_container.dart';
import 'package:al_amine_store/common/widget/section_heading.dart';
import 'package:al_amine_store/features/home/controller/home_controller.dart';
import 'package:al_amine_store/features/home/presentation/widgets/app_primary_header_container.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/routes.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });
  //final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    HomeControllerImpl homeController = Get.put(HomeControllerImpl());

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          AppPrimaryHeaderContainer(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppSizes.defaultSpace,
                  right: AppSizes.defaultSpace,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "7".tr,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.white,
                              ),
                    ),
                    const Spacer(),
                    ClipOval(
                      child: Image.asset("assets/store_logo.jpg",
                          cacheWidth: 175,
                          cacheHeight: 175,
                          scale: 3.5,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      }),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
              AppSearchContainer(
                onTap: () {
                  Get.toNamed(AppRoute.priceListPage);
                },
                text: "8".tr,
              ),
              const SizedBox(
                height: AppSizes.spaceBtwSections,
              ),
            ],
          )),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSectionHeading(
                  title: "9".tr,
                  showActionButton: false,
                ),
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
                        title: "10".tr,
                        icon: Iconsax.add,
                        onTap: () {
                          homeController.goToProductPage();
                        },
                      ),
                      ButtonContainer(
                        title: "11".tr,
                        icon: Icons.list,
                        onTap: () => homeController.goToPriceListPage(),
                      ),
                      ButtonContainer(
                        title: "12".tr,
                        icon: Icons.attach_money,
                        onTap: () => homeController.goToSalesPage(),
                      ),
                      ButtonContainer(
                        title: "13".tr,
                        icon: Icons.money_off,
                        onTap: () => homeController.goToExpnesesPage(),
                      ),
                      ButtonContainer(
                        title: "14".tr,
                        icon: Icons.bar_chart,
                        onTap: () => homeController.goToTablePage(),
                      ),
                      ButtonContainer(
                        title: "15".tr,
                        icon: Iconsax.logout,
                        onTap: () => homeController.logout(),
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
