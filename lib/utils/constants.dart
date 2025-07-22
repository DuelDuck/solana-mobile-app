import 'package:flutter/material.dart';

class ProjectConstants {
  static const String bottomBarStatusActive = "_active.";
}

class ProjectSource {
  static const String bottomBarHome =
      "assets/images/bottom_bar/bottom_bar_home.svg";
  static const String bottomBarHomeActive =
      "assets/images/bottom_bar/bottom_bar_home_active.svg";
  static const String bottomBarDuels =
      "assets/images/bottom_bar/bottom_bar_duels.svg";
  static const String bottomBarAddDuel =
      "assets/images/bottom_bar/bottom_bar_add.svg";
  static const String bottomBarProfile =
      "assets/images/bottom_bar/bottom_bar_profile.svg";
}

class ProjectFonts {
  static const TextStyle headerRegular = TextStyle(
    fontFamily: "Bungee",
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static const TextStyle bodySemibold = TextStyle(
    fontFamily: "Poppins",
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static const TextStyle bodyRegular = TextStyle(
    fontFamily: "Poppins",
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
}

class ProjectColors {
  static const Color backgroundBlack = Color(0xff070707);
  static const Color grey = Color(0xffA7A7A7);
  static const Color black = Color(0xff151515);
  static const Color yellow = Color(0xffFFC54D);
}

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: ProjectColors.yellow),
  appBarTheme: AppBarTheme(
    backgroundColor: ProjectColors.backgroundBlack,
    surfaceTintColor: Colors.transparent,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: ProjectColors.backgroundBlack,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    backgroundColor: ProjectColors.black,
    selectedItemColor: ProjectColors.yellow,
    unselectedItemColor: ProjectColors.grey,
    selectedLabelStyle: ProjectFonts.bodyRegular.copyWith(fontSize: 12),
    unselectedLabelStyle: ProjectFonts.bodyRegular.copyWith(fontSize: 12),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: ProjectColors.backgroundBlack,
);
