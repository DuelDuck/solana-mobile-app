import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

enum ToastType { custom, success, error }

/// AppToast. To show the toast call [show()] on its instance.
class CustomToast extends StatelessWidget {
  final String text;

  final Widget? icon;
  final TextAlign? textAlign;

  final ToastType type;

  const CustomToast._({
    required this.text,
    this.icon,
    required this.type,
    this.textAlign = TextAlign.center,
  });

  factory CustomToast.custom(
    String text, {
    Widget? icon,
    TextAlign? textAlign,
  }) {
    return CustomToast._(
      text: text,
      icon: icon,
      type: ToastType.custom,
      textAlign: textAlign,
    );
  }

  factory CustomToast.success(String text) {
    return CustomToast._(text: text, type: ToastType.success);
  }

  factory CustomToast.error(String text) {
    return CustomToast._(text: text, type: ToastType.error);
  }

  void show(
    BuildContext context, {
    Duration autoCloseDuration = const Duration(seconds: 4),
  }) {
    toastification.showCustom(
      context: context,
      autoCloseDuration: autoCloseDuration,
      builder: (context, item) {
        // TODO(waiting for fix from package side): Check once the fix is ready
        // Align needed to put the toast in the center of x axis.
        // For more, see: https://github.com/payam-zahedi/toastification/issues/195
        return Align(child: this);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      decoration: BoxDecoration(
        color: ProjectColors.black,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12, right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: CustomText.basic(
              text: text,
              style: ProjectFonts.bodyMedium,
              maxLines: 3,
              textAlign: textAlign,
            ),
          ),
        ],
      ),
    );
  }
}
