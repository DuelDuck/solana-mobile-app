import 'package:flutter/material.dart';

class Utils {
  static autocorrectMinValue({
    required String value,
    required int minValue,
    required TextEditingController controller,
  }) {
    final number = int.tryParse(value);
    if (number != null && number < 1) {
      controller.text = minValue.toString();
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length),
      );
    }
  }
}
