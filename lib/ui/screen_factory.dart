import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:duelduck_solana/ui/screens/add_duel/add_duel_screen.dart';
import 'package:duelduck_solana/ui/screens/duels/duels_screen.dart';
import 'package:duelduck_solana/ui/screens/home/home_screen.dart';
import 'package:duelduck_solana/ui/screens/main_screen/main_screen.dart';
import 'package:duelduck_solana/ui/screens/no_internet_connection/no_internet_connection_screen.dart';
import 'package:duelduck_solana/ui/screens/profile/profile_screen.dart';

class ScreenFactory {
  const ScreenFactory();

  Widget mainScreen(BuildContext context, GoRouterState state, Widget child) {
    return MainScreen(child: child);
  }

  Widget homeScreen(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }

  Widget duelsScreen(BuildContext context, GoRouterState state) {
    return const DuelsScreen();
  }

  Widget addDuelScreen(BuildContext context, GoRouterState state) {
    return const AddDuelScreen();
  }

  Widget profileScreen(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }

  Widget noInternetConnectionScreen(BuildContext context, GoRouterState state) {
    return const NoInternetConnectionScreen();
  }
}
