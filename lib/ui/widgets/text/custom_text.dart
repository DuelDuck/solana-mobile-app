import 'package:flutter/material.dart';

import 'package:duelduck_solana/utils/constants.dart';

enum TypeCustomText { basic, title, handleLink }

class CustomText extends StatelessWidget {
  final TypeCustomText type;
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? fontSize;
  final Color? color;

  const CustomText.title({
    super.key,
    required this.text,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.color,
    this.fontSize,
  }) : type = TypeCustomText.title,
       style = null;

  const CustomText.basic({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.color,
    this.fontSize,
  }) : type = TypeCustomText.basic;

  const CustomText.handleLink({
    super.key,
    required this.text,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.style,
    this.color,
    this.fontSize,
  }) : type = TypeCustomText.handleLink;

  @override
  Widget build(BuildContext context) {
    if (type == TypeCustomText.title) {
      return Text(
        text,
        style:
            style ??
            ProjectFonts.headerRegular.copyWith(
              color: color,
              fontSize: fontSize,
            ),
        textAlign: textAlign,
        overflow: overflow,
      );
    }

    return Text(
      text,
      style:
          style ??
          ProjectFonts.bodyRegular.copyWith(color: color, fontSize: fontSize),
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
