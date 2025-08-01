import 'package:duelduck_solana/bloc/duels_cubit/duels_cubit.dart';
import 'package:duelduck_solana/ui/screens/duels/widgets/created_duels_list.dart';
import 'package:duelduck_solana/ui/screens/duels/widgets/done_duels_list.dart';
import 'package:duelduck_solana/ui/screens/duels/widgets/pending_duels_list.dart';
import 'package:duelduck_solana/ui/screens/duels/widgets/voted_duels_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:duelduck_solana/utils/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DuelsScreen extends StatefulWidget {
  const DuelsScreen({super.key});

  @override
  State<DuelsScreen> createState() => _DuelsScreenState();
}

class _DuelsScreenState extends State<DuelsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
    return BlocBuilder<DuelsCubit, DuelsState>(
      builder: (context, state) {
        if (state is DuelsLoading) {
          return Center(
            child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Column(
          children: [
            const SizedBox(height: 16),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: ProjectColors.black,
                borderRadius: BorderRadius.circular(100),
              ),
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildTabButton("duels_screen_voted_tab".tr(), 0),
                  _buildTabButton("duels_screen_created_tab".tr(), 1),
                  _buildTabButton("duels_screen_pending_tab".tr(), 2),
                  _buildTabButton("duels_screen_done_tab".tr(), 3),
                ],
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  VotedDuelsList(votedDuelsList: state.votedDuelsList),
                  CreatedDuelsList(createdDuelsList: state.createdDuelsList),
                  PendingDuelsList(pendingDuelsList: state.pendingDuelsList),
                  DoneDuelsList(doneDuelsList: state.doneDuelsList),
                ],
              ),
            ),
          ],
        );
      },
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
