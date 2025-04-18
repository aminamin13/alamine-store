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
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeControllerImpl homeController = Get.put(HomeControllerImpl());

    return PopScope(
      canPop: false,

      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            bool isWideScreen = screenWidth > 600; // Tablet & Desktop

            return SingleChildScrollView(
              child: Column(
                children: [
                  /// --- HEADER SECTION ---
                  AppPrimaryHeaderContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppSizes.spaceBtwSections),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.defaultSpace,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// --- Title ---
                              Text(
                                "7".tr,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                  fontSize: isWideScreen ? 28 : 22,
                                ),
                              ),
                              const Spacer(),

                              /// --- Logo ---
                              ClipOval(
                                child: Image.asset(
                                  "assets/store_logo.jpg",
                                  cacheWidth: 175,
                                  cacheHeight: 175,
                                  scale: 3.5,
                                  width: isWideScreen ? 70 : 50,
                                  height: isWideScreen ? 70 : 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.spaceBtwSections),

                        /// --- Search Bar ---
                        AppSearchContainer(
                          onTap: () {
                            Get.toNamed(AppRoute.priceListPage);
                          },
                          text: "8".tr,
                        ),
                        const SizedBox(height: AppSizes.spaceBtwSections),
                      ],
                    ),
                  ),

                  /// --- BUTTON GRID SECTION ---
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.defaultSpace,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// --- Section Title ---
                        AppSectionHeading(
                          title: "9".tr,
                          showActionButton: false,
                        ),

                        /// --- Responsive GridView ---
                        LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount = 2;

                            if (screenWidth > 1200) {
                              crossAxisCount = 4; // Desktop
                            } else if (screenWidth > 800) {
                              crossAxisCount = 3; // Tablet
                            }

                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    mainAxisExtent: 110,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 6,
                              itemBuilder: (context, index) {
                                return _buildButton(homeController, index);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// --- Button List ---
  Widget _buildButton(HomeControllerImpl homeController, int index) {
    List<Map<String, dynamic>> buttons = [
      {
        "title": "10".tr,
        "icon": Iconsax.add,
        "onTap": homeController.goToProductPage,
      },
      {
        "title": "11".tr,
        "icon": Icons.list,
        "onTap": homeController.goToPriceListPage,
      },
      {
        "title": "12".tr,
        "icon": Icons.attach_money,
        "onTap": homeController.goToSalesPage,
      },
      {
        "title": "13".tr,
        "icon": Icons.money_off,
        "onTap": homeController.goToExpnesesPage,
      },
      {
        "title": "14".tr,
        "icon": Icons.bar_chart,
        "onTap": homeController.goToTablePage,
      },
      {
        "title": "15".tr,
        "icon": Iconsax.logout,
        "onTap": homeController.logout,
      },
    ];

    return ButtonContainer(
      title: buttons[index]["title"],
      icon: buttons[index]["icon"],
      onTap: buttons[index]["onTap"],
    );
  }
}

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({
    super.key,
    required this.title,
    this.onTap,
    required this.icon,
  });

  final String title;
  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        padding: const EdgeInsets.all(10),
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
          children: [
            Icon(icon, size: 40, color: AppColors.grey),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
