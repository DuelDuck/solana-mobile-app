import 'package:flutter/material.dart';

import 'package:duelduck_solana/utils/constants.dart';

class AddDuelScreen extends StatelessWidget {
  const AddDuelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "AddDuelScreen",
        style: ProjectFonts.headerRegular.copyWith(color: Colors.white),
      ),
    );
  }
}
