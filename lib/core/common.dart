import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showWarningMessage(text) {
  Get.snackbar(
      'warn'.tr, text,
      icon: const Icon(Icons.warning_amber_outlined, color: Colors.white,),
      backgroundColor: Colors.orange,
      snackPosition:SnackPosition.BOTTOM,
      colorText: Colors.white
  );
}

void showSuccessMessage(text) {
  Get.snackbar(
      'success'.tr, text,
      icon: const Icon(Icons.check_circle_outline, color: Colors.white,),
      backgroundColor: Colors.green,
      snackPosition:SnackPosition.BOTTOM,
      colorText: Colors.white
  );
}

void showErrorMessage(text) {
  Get.snackbar(
      'error'.tr, text,
      icon: const Icon(Icons.error_outline, color: Colors.white,),
      backgroundColor: Colors.red,
      snackPosition:SnackPosition.BOTTOM,
      colorText: Colors.white
  );
}
