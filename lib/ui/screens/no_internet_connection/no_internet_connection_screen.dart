import 'package:flutter/material.dart';

import 'package:duelduck_solana/utils/constants.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  const NoInternetConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "NoInternetConnectionScreen",
          style: ProjectFonts.headerRegular.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
