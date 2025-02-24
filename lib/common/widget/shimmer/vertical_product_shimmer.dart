import 'package:al_amine_store/common/widget/layout/grid_layout.dart';
import 'package:al_amine_store/common/widget/shimmer/shimmer_effect.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
 

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return AppGridLayout(
        ItemCount: itemCount,
        itemBuilder: (p0, p1) {
          const SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmerEffect(
                  width: 180,
                  height: 180,
                ),
                SizedBox(
                  height: AppSizes.spaceBtwItems,
                ),
                AppShimmerEffect(width: 160, height: 15),
                SizedBox(
                  height: AppSizes.spaceBtwItems / 2,
                ),
                AppShimmerEffect(width: 110, height: 15)
              ],
            ),
          );

          return null;
        });
  }
}
