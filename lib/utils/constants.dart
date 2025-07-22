import 'package:flutter/material.dart';

class ProjectConstants {}

class ProjectSource {
  static const String bottomBarHome =
      "assets/images/bottom_bar/bottom_bar_home.svg";
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
