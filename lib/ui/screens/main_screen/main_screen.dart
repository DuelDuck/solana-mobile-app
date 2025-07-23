import 'package:flutter/material.dart';

import 'package:duelduck_solana/ui/widgets/app_bar/custom_app_bar.dart';
import 'package:duelduck_solana/ui/widgets/bottom_bar/bottom_bar.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({super.key, required this.child});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        nameWallet: "xdcftvygbuhnij", //TODO: name
        onTapLogOut: () {},
      ),
      body: widget.child,
      bottomNavigationBar: BottomBar(),
    );
  }
}
