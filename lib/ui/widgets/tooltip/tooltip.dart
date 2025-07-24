import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_tooltip/super_tooltip.dart';

class TooltipWidget extends StatelessWidget {
  final String text;
  TooltipWidget({super.key, required this.text});

  final _controller = SuperTooltipController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _controller.showTooltip();
      },
      child: SuperTooltip(
        showBarrier: true,
        controller: _controller,
        backgroundColor: ProjectColors.backgroundDark,
        borderColor: ProjectColors.primaryYellow,
        content: CustomText.basic(
          text: text,
          style: ProjectFonts.bodySmall.copyWith(color: ProjectColors.grey),
        ),
        child: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ProjectColors.primaryYellow.withAlpha(10),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(ProjectSource.questionIcon),
        ),
      ),
    );
  }
}
