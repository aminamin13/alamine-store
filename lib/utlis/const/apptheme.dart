import 'package:al_amine_store/utlis/const/colors.dart';
 import 'package:flutter/material.dart';

ThemeData themeEnglish = ThemeData(
    fontFamily: "PlayfairDisplay",
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[50],
        titleTextStyle: const TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontFamily: "PlayfairDisplay",
            fontWeight: FontWeight.bold),
        centerTitle: true,
        elevation: 0),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary, foregroundColor: Colors.white),
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 30,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
            fontSize: 14,
            color: AppColors.grey,
            fontWeight: FontWeight.bold,
            height: 2)));
ThemeData themeArabic = ThemeData(
    fontFamily: "Cairo",
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: AppColors.primary),
        backgroundColor: Colors.grey[50],
        titleTextStyle: const TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontFamily: "Cairo",
            fontWeight: FontWeight.bold),
        centerTitle: true,
        elevation: 0),
    primarySwatch: Colors.blue,
    textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 30,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
            fontSize: 14,
            color: AppColors.grey,
            fontWeight: FontWeight.bold,
            height: 2)));
