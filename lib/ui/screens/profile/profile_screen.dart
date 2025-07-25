import 'package:duelduck_solana/ui/screens/profile/widgets/referral_widget.dart';
import 'package:duelduck_solana/ui/screens/profile/widgets/stats_widget.dart';
import 'package:duelduck_solana/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: ProjectColors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                children: [
                  _buildTabButton("profile_screen_tab_button_stats".tr(), 0),
                  _buildTabButton("profile_screen_tab_button_referral".tr(), 1),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: const [StatsWidget(), ReferralWidget()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border:
                isSelected
                    ? Border.all(color: ProjectColors.primaryYellow, width: 2)
                    : null,
          ),
          child: Text(
            text,
            style:
                isSelected
                    ? ProjectFonts.bodySmall.copyWith(
                      color: ProjectColors.primaryYellow,
                    )
                    : ProjectFonts.bodySmall.copyWith(
                      color: ProjectColors.grey,
                    ),
          ),
        ),
      ),
    );
  }
}
