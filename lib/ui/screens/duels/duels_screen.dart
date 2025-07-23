import 'package:flutter/material.dart';

import 'package:duelduck_solana/utils/constants.dart';

class DuelsScreen extends StatelessWidget {
  const DuelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "DuelsScreen",
        style: ProjectFonts.headerRegular.copyWith(color: Colors.white),
      ),
    );
  }
}
