import 'package:flutter/material.dart';

enum TypeCustomText { basic }

class CustomText extends StatelessWidget {
  final TypeCustomText type;
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomText.basic({
    super.key,
    required this.text,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.type = TypeCustomText.basic,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
