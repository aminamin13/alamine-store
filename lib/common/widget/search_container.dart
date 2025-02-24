import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:al_amine_store/utlis/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppSearchContainer extends StatelessWidget {
  const AppSearchContainer({
    super.key,
    required this.text,
    this.icon,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding =
        const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.md),
          decoration: BoxDecoration(
              color: showBackground
                  ? dark
                      ? AppColors.dark
                      : AppColors.white
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
              border: showBorder ? Border.all(color: AppColors.grey) : null),
          child: Row(children: [
            const Icon(Iconsax.search_normal, color: AppColors.darkerGrey),
            const SizedBox(
              width: AppSizes.spaceBtwItems,
            ),
            Text(text, style: Theme.of(context).textTheme.bodySmall),
          ]),
        ),
      ),
    );
  }
}
