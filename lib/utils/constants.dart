import 'package:flutter/material.dart';

class ProjectConstants {}

class ProjectSource {
  static const String completeIcon = "assets/icons/complete_icon.svg";
  static const String arrowBottomIcon = "assets/icons/arrow_bottom_icon.svg";
  static const String arrowTopIcon = "assets/icons/arrow_top_icon.svg";
  static const String addImageIcon = "assets/icons/add_image_icon.svg";
  static const String closeIcon = "assets/icons/close_icon.svg";
  static const String calendarIcon = "assets/icons/calendar_icon.svg";
  static const String usdcIcon = "assets/icons/usdc_icon.svg";
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
  static const Color backgroundSecondaryDark = Color(0xff151515);
  static const Color grey = Color(0xffA7A7A7);
  static const Color primaryYellow = Color(0xffFFC54D);
  static const Color greySecondary = Color(0xff2e302e);
  static const Color greyBorder = Color(0xff2c2c2c);
}
