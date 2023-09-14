import 'package:get/get.dart';

// Class containing static methods for input validation
class Validator {
  // Validate email input
  static String? validateEmails(String value) {
    if (value.isEmpty) {
      return "Please enter Email";
    } else if (!GetUtils.isEmail(value)) {
      return "Please check Email Id";
    }
    return null;
  }

  // Validate password input
  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Please enter Password";
    } else if (value.length < 8) {
      return "Password must be 8 characters long";
    }
    return null;
  }

  // Validate name input
  static String? validateName(String value) {
    if (value.isEmpty) {
      return "Please enter Name";
    } else if (value.length < 2) {
      return "Name must have at least 2 characters";
    }
    return null;
  }

  // Validate experience input
  static String? validateExp(String value) {
    if (value.isEmpty) {
      return "Please enter Experience";
    } else if (int.tryParse(value) == null || int.parse(value) > 99) {
      return "Please enter valid Experience";
    }
    return null;
  }
}
