import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:duelduck_solana/ui/screens/routing.dart';
import 'package:duelduck_solana/utils/constants.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = indexCurrentRoute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      /// For disable color animation in BottomBar
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
      ),
      child: Material(
        elevation: 5,
        color: ProjectColors.backgroundDark,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: getTabs(),
            currentIndex: currentIndex,
            onTap: (index) => changeTab(index),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavigationItem({
    required String label,
    required String sourceSVG,
  }) {
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(sourceSVG),
      activeIcon: SvgPicture.asset(
        sourceSVG.replaceAll(".", ProjectConstants.bottomBarStatusActive),
      ),

      label: label.tr(),
    );
  }

  List<BottomNavigationBarItem> getTabs() {
    return [
      _buildNavigationItem(
        label: "bottom_bar_label_home",
        sourceSVG: ProjectSource.bottomBarHomeIcon,
      ),
      _buildNavigationItem(
        label: "bottom_bar_label_duels",
        sourceSVG: ProjectSource.bottomBarDuelsIcon,
      ),
      _buildNavigationItem(
        label: "bottom_bar_label_add_duel",
        sourceSVG: ProjectSource.bottomBarAddDuelIcon,
      ),
      _buildNavigationItem(
        label: "bottom_bar_label_profile",
        sourceSVG: ProjectSource.bottomBarProfileIcon,
      ),
    ];
  }

  changeTab(int index) {
    switch (index) {
      case 0:
        context.go(AppRouter.home);
        break;

      case 1:
        context.go(AppRouter.duels);
        break;

      case 2:
        context.go(AppRouter.addDuel);
        break;

      case 3:
        context.go(AppRouter.profile);
        break;

      default:
        context.go(AppRouter.home);
        break;
    }

    setState(() => currentIndex = index);
  }

  int indexCurrentRoute() {
    String currentRoute =
        GoRouter.of(
          context,
        ).routeInformationProvider.value.uri.toString().toLowerCase();

    if (currentRoute.contains(AppRouter.home.toLowerCase())) {
      return 0;
    }
    if (currentRoute.contains(AppRouter.duels.toLowerCase())) {
      return 1;
    }
    if (currentRoute.contains(AppRouter.addDuel.toLowerCase())) {
      return 2;
    }

    return 0;
  }
}
