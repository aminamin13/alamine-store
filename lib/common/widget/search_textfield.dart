import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:al_amine_store/utlis/helpers/helpers_function.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppSearchTextField extends StatelessWidget {
  const AppSearchTextField({
    super.key,
    required this.text,
    this.icon,
    this.showBackground = true,
    this.showBorder = true,
    this.padding =
        const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
    this.controller, this.onChanged,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunctions.isDarkMode(context);
    return Padding(
      padding: padding,
      child: TextFormField(
        onChanged: onChanged ,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(AppSizes.md),
          filled: showBackground,
          
          fillColor: showBackground
              ? dark
                  ? AppColors.dark
                  : AppColors.white
              : Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
            borderSide: showBorder
                ? BorderSide(color: AppColors.grey)
                : BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
            borderSide: BorderSide(color: AppColors.grey),
          ),
          prefixIcon:
              const Icon(Iconsax.search_normal, color: AppColors.darkerGrey),
          hintText: text,
          hintStyle: Theme.of(context).textTheme.bodySmall,
        ),
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
