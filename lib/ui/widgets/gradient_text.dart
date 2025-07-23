import 'package:duelduck_solana/utils/constants.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;

  const GradientText({super.key, required this.text, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.white, ProjectColors.gradientGrey],
        ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
      },
      blendMode: BlendMode.srcIn,
      child: Text(text, style: textStyle),
    );
  }
}
