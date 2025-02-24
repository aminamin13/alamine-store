import 'package:al_amine_store/common/widget/layout/grid_layout.dart';
import 'package:al_amine_store/common/widget/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';
 

class AppBrandsShimmer extends StatelessWidget {
  const AppBrandsShimmer({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return AppGridLayout(
        ItemCount: itemCount,
        itemBuilder: (itemContext, index) {
          AppShimmerEffect(width: 300, height: 80);
          return null;
        });
  }
}
