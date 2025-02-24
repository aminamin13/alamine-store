import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:al_amine_store/utlis/helpers/helpers_function.dart';
import 'package:flutter/material.dart';

class AppAnimationLoaderWidget extends StatelessWidget {
  const AppAnimationLoaderWidget(
      {super.key,
      required this.text,
      this.actionText,
      this.showAction = false,
      this.onActionPressed});

  final String text;
  final String? actionText;
  final bool showAction;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: AppSizes.defaultSpace,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSizes.defaultSpace,
          ),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: AppHelperFunctions.isDarkMode(context)
                          ? AppColors.darkerGrey
                          : AppColors.black,
                    ),
                    onPressed: onActionPressed,
                    child: Text(
                      actionText!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: AppColors.white),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
