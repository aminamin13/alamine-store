import 'package:al_amine_store/common/widget/app_curved_edge_widget.dart';
import 'package:al_amine_store/common/widget/circular_container.dart';
import 'package:al_amine_store/utlis/const/colors.dart';
import 'package:flutter/material.dart';

class AppPrimaryHeaderContainer extends StatelessWidget {
  const AppPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppCurvedEdgeWidget(
      child: Container(
          color: AppColors.primary,
          padding: const EdgeInsets.all(0),
          child: Stack(children: [
            Positioned(
              top: -150,
              right: -250,
              child: AppCircularContainer(
                  backgroundColor: AppColors.white.withOpacity(0.1)),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: AppCircularContainer(
                  backgroundColor: AppColors.white.withOpacity(0.1)),
            ),
            child
          ])),
    );
  }
}
