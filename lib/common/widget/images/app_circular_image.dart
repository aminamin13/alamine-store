import 'package:al_amine_store/common/widget/shimmer/shimmer_effect.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:al_amine_store/utlis/helpers/helpers_function.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCircularImage extends StatelessWidget {
  const AppCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 70,
    this.height = 70,
    this.padding = AppSizes.sm,
  });

  final BoxFit? fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: backgroundColor ??
              (AppHelperFunctions.isDarkMode(context)
                  ? AppColors.black
                  : AppColors.white)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(
                  fit: fit,
                  color: overlayColor,
                  imageUrl: image,
                  progressIndicatorBuilder: (context, url, progress) =>
                      const AppShimmerEffect(width: 55, height: 55),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(image: AssetImage(image), color: overlayColor),
        ),
      ),
    );
  }
}
