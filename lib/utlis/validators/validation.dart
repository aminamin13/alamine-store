import 'package:get/get.dart';

class AppValidator {
  static String? validateEmptyText(String fieldKey, String? value) {
    if (value == null || value.isEmpty) {
      return "33".trParams({"fieldName": fieldKey}).replaceAll("{}", fieldKey);
    }
    return null;
  }

  // static String? validateEmail(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Email is required.';
  //   }

  //   // Regular expression for email validation
  //   final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  //   if (!emailRegExp.hasMatch(value)) {
  //     return 'Invalid email address.';
  //   }

  //   return null;
  // }

  static String? validateNumber(String fieldKey, String? value) {
    if (value == null || value.isEmpty) {
      return "33".trParams({"fieldName": fieldKey}).replaceAll("{}", fieldKey);
    }

    // Convert Arabic numerals to Western numerals before validation
    String convertedValue = convertArabicNumbers(value);

    // Check if the converted value is a valid number
    final number = num.tryParse(convertedValue);
    if (number == null) {
      return 'Please enter a valid number';
    }

    return null; // No error, return null
  }

  static String convertArabicNumbers(String input) {
    const arabicToWestern = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9'
    };

    return input.split('').map((char) => arabicToWestern[char] ?? char).join();
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{8}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (8 digits required).';
    }

    return null;
  }

// Add more custom validators as needed for your specific requirements.
}
