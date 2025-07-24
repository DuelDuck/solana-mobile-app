import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:flutter/material.dart';

enum TypeCustomButton { basic }

class CustomButton extends StatelessWidget {
  final Color? background;
  final Color? backgroundDisableButton;
  final String title;
  final TypeCustomButton type;
  final Color? borderSideColor;
  final Color? borderSideColorDisableButton;
  final Widget? child;
  final TextStyle textStyleTitle;
  final double? borderRadius;
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;
  final double? buttonHeight;
  final bool isActiveButton;
  final Function onPressed;

  const CustomButton({
    super.key,
    this.title = "",
    this.background,
    this.backgroundDisableButton,
    this.borderSideColor,
    this.borderSideColorDisableButton,
    this.child,
    required this.textStyleTitle,
    this.borderRadius,
    this.padding,
    this.buttonHeight = 48,
    this.isActiveButton = true,
    required this.onPressed,
  }) : type = TypeCustomButton.basic;

  @override
  Widget build(BuildContext context) {
    return buildBasicButton();
  }

  Widget buildBasicButton() {
    final Color backgroundColor =
        isActiveButton
            ? background ?? ProjectColors.greyBlack
            : backgroundDisableButton ?? ProjectColors.greyBlack;
    final Color borderColor =
        isActiveButton
            ? borderSideColor ?? ProjectColors.greyBlack
            : borderSideColorDisableButton ?? ProjectColors.greyBlack;

    return SizedBox(
      height: buttonHeight,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: padding,
          elevation: WidgetStateProperty.all(0),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
          backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius ?? 15),
              ),
              side: BorderSide(color: borderColor),
            ),
          ),
          alignment: Alignment.center,
        ),
        onPressed: () {
          if (!isActiveButton) return;
          onPressed();
        },
        child:
            child ??
            Center(child: CustomText.basic(text: title, style: textStyleTitle)),
      ),
    );
  }
}
