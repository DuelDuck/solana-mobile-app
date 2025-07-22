import 'package:flutter/material.dart';

import 'package:duelduck_solana/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "HomeScreen",
        style: ProjectFonts.headerRegular.copyWith(color: Colors.white),
      ),
    );
  }
}
