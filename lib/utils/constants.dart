import 'package:flutter/material.dart';

class ProjectConstants {
  static const String bottomBarStatusActive = "_active.";
}

class ProjectSource {
  static const String completeIcon = "assets/icons/complete_icon.svg";
  static const String arrowBottomIcon = "assets/icons/arrow_bottom_icon.svg";
  static const String arrowTopIcon = "assets/icons/arrow_top_icon.svg";
  static const String addImageIcon = "assets/icons/add_image_icon.svg";
  static const String closeIcon = "assets/icons/close_icon.svg";
  static const String calendarIcon = "assets/icons/calendar_icon.svg";
  static const String usdcIcon = "assets/icons/usdc_icon.svg";
  static const String shareIcon = "assets/icons/share_icon.svg";
  static const String duckIcon = "assets/icons/duck_icon.svg";
  static const String selectedVoteButton =
      "assets/icons/selected_vote_button_icon.svg";
  static const String bottomBarHomeIcon =
      "assets/icons/bottom_bar/bottom_bar_home.svg";
  static const String bottomBarHomeIconActiveIcon =
      "assets/icons/bottom_bar/bottom_bar_home_active.svg";
  static const String bottomBarDuelsIcon =
      "assets/icons/bottom_bar/bottom_bar_duels.svg";
  static const String bottomBarAddDuelIcon =
      "assets/icons/bottom_bar/bottom_bar_add.svg";
  static const String bottomBarProfileIcon =
      "assets/icons/bottom_bar/bottom_bar_profile.svg";

  static const String logoCircle = "assets/images/logo/logo.png";
  static const String iconWallet = "assets/images/icon_wallet.png";
  static const String logOut = "assets/images/logout.png";
  static const String noConnectionLogo =
      "assets/images/logo/no_connection_logo.svg";
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
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: "Poppins",
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const TextStyle bodyRegular = TextStyle(
    fontFamily: "Poppins",
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: "Poppins",
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
}

class ProjectColors {
  static const Color backgroundDark = Color(0xff070707);
  static const Color gradientGrey = Color(0xff686666);
  static const Color grey = Color(0xffA7A7A7);
  static const Color primaryYellow = Color(0xffFFC54D);
  static const Color greySecondary = Color(0xff2e302e);
  static const Color greyBorder = Color(0xff2c2c2c);
  static const Color black = Color(0xff151515);
  static const Color greyBlack = Color(0xff212121);
  static const Color red = Color(0xffF6762E);
  static const Color green = Color(0xffB0D356);
}

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: ProjectColors.primaryYellow),
  appBarTheme: AppBarTheme(
    backgroundColor: ProjectColors.backgroundDark,
    surfaceTintColor: Colors.transparent,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: ProjectColors.backgroundDark,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
    backgroundColor: ProjectColors.greyBlack,
    selectedItemColor: ProjectColors.primaryYellow,
    unselectedItemColor: ProjectColors.grey,
    selectedLabelStyle: ProjectFonts.bodyRegular.copyWith(fontSize: 12),
    unselectedLabelStyle: ProjectFonts.bodyRegular.copyWith(fontSize: 12),
  ),
  useMaterial3: true,
  scaffoldBackgroundColor: ProjectColors.backgroundDark,
);
