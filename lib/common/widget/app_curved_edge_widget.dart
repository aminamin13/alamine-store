import 'package:al_amine_store/common/widget/app_custom_curved_edge.dart';
import 'package:flutter/material.dart';
 
class AppCurvedEdgeWidget extends StatelessWidget {
  const AppCurvedEdgeWidget({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: AppCustomCurvedEdges(), child: child);
  }
}
