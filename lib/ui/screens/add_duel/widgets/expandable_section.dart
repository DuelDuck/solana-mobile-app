import 'package:duelduck_solana/ui/widgets/animation/animated_clip_rect.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ExpandableSection extends StatefulWidget {
  final String title;
  final Widget child;
  final bool isExpanded;
  final bool isFilled;

  const ExpandableSection({
    super.key,
    required this.title,
    required this.child,
    this.isExpanded = false,
    this.isFilled = false,
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection>
    with TickerProviderStateMixin {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: ProjectColors.backgroundSecondaryDark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: _isExpanded ? Radius.zero : Radius.circular(15),
                bottomRight: _isExpanded ? Radius.zero : Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.only(
              left: 16,
              top: 18,
              right: 20,
              bottom: _isExpanded ? 8 : 18,
            ),
            child: Row(
              children: [
                widget.isFilled
                    ? SvgPicture.asset(ProjectSource.completeIcon)
                    : SizedBox(),
                if (widget.isFilled) const SizedBox(width: 8),
                Text(
                  widget.title,
                  style: ProjectFonts.bodySemibold.copyWith(
                    color: _isExpanded ? null : ProjectColors.grey,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  _isExpanded
                      ? ProjectSource.arrowTopIcon
                      : ProjectSource.arrowBottomIcon,
                ),
              ],
            ),
          ),
        ),
        AnimatedClipRect(
          open: _isExpanded,
          horizontalAnimation: false,
          verticalAnimation: true,
          duration: const Duration(milliseconds: 300),
          child: Container(
            padding: EdgeInsets.only(bottom: 25, left: 16, right: 16),
            decoration: BoxDecoration(
              color: ProjectColors.backgroundSecondaryDark,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
