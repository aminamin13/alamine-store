import 'package:al_amine_store/common/widget/shimmer/shimmer_effect.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
 

class AppCategoryShimmer extends StatelessWidget {
  const AppCategoryShimmer({super.key, this.itemCount = 6});

  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        itemCount: itemCount,
        separatorBuilder: (context, index) {
          return const SizedBox(width: AppSizes.spaceBtwItems);
        },
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppShimmerEffect(
                width: 55,
                height: 55,
                radius: 55,
              ),
              SizedBox(
                height: AppSizes.spaceBtwItems / 2,
              ),
              AppShimmerEffect(
                width: 55,
                height: 8,
              ),
            ],
          );
        },
      ),
    );
  }
}
