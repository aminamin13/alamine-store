import 'package:al_amine_store/utlis/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white, // Optional: background color
            borderRadius: BorderRadius.circular(20), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                blurRadius: 10, // Spread of the shadow
                spreadRadius: 2,
                offset: Offset(5, 5), // Position of the shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                20), // Ensures image corners match the container
            child: Image.asset(
              'assets/store_logo.jpg', // Replace with your image path
              width: 200, // Image width
              height: 100, // Image height
              fit: BoxFit.cover, // Adjust image to fit the container
            ),
          ),
        ),
        const SizedBox(
          height: AppSizes.lg,
        ),
        Text("1".tr, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(
          height: AppSizes.sm,
        ),
        Text("2".tr, style: Theme.of(context).textTheme.bodyMedium)
      ],
    );
  }
}
