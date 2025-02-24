import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar(
      {super.key,
      this.title,
      this.showBackArrow = false,
      this.leadingIcon,
      this.actions,
      this.leadingOnPressed,
      this.isTranspernet,
      this.backgroundColor});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool? isTranspernet;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          isTranspernet == true ? Colors.transparent : backgroundColor,
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Iconsax.arrow_left))
          : leadingIcon != null
              ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon))
              : null,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
        child: title,
      ),
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
