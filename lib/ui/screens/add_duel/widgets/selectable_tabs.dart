import 'package:duelduck_solana/ui/widgets/text/custom_text.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:flutter/material.dart';

class SelectableTabs extends StatefulWidget {
  final List<String> tabs;
  final Widget? itemIcon;
  final ValueChanged<String> onTabSelected;

  const SelectableTabs({
    super.key,
    required this.tabs,
    this.itemIcon,
    required this.onTabSelected,
  });

  @override
  State<SelectableTabs> createState() => _SelectableTabsState();
}

class _SelectableTabsState extends State<SelectableTabs> {
  String? selectedTab;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 16,
      children:
          widget.tabs.map((tab) {
            final bool isSelected = tab == selectedTab;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = tab;
                });
                widget.onTabSelected(tab);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: ProjectColors.black,
                  border: Border.all(
                    color:
                        isSelected
                            ? ProjectColors.primaryYellow
                            : ProjectColors.greyBorder,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (widget.itemIcon != null) ...[
                      widget.itemIcon!,
                      const SizedBox(width: 8),
                    ],
                    CustomText.basic(
                      text: tab,
                      style:
                          isSelected
                              ? ProjectFonts.bodyRegular.copyWith(
                                color: ProjectColors.primaryYellow,
                              )
                              : ProjectFonts.bodyRegular.copyWith(
                                color: ProjectColors.gradientGrey,
                              ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }
}
