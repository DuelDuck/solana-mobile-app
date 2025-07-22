import 'package:flutter/material.dart';

import 'package:duelduck_solana/utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "ProfileScreen",
        style: ProjectFonts.headerRegular.copyWith(color: Colors.white),
      ),
    );
  }
}
