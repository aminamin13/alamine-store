import 'package:al_amine_store/common/widget/shimmer/shimmer_effect.dart';
import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
 

class AppBoxShimmer extends StatelessWidget {
  const AppBoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(
                child: AppShimmerEffect(
              height: 110,
              width: 150,
            )),
            SizedBox(
              width: AppSizes.spaceBtwItems,
            ),
            Expanded(
                child: AppShimmerEffect(
              height: 110,
              width: 150,
            )),
            SizedBox(
              width: AppSizes.spaceBtwItems,
            ),
            Expanded(
                child: AppShimmerEffect(
              height: 110,
              width: 150,
            )),
          ],
        )
      ],
    );
  }
}
