import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:duelduck_solana/bloc/connectivity_cubit/connectivity_cubit.dart';
import 'package:duelduck_solana/ui/screen_factory.dart';

final parentNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static const String noInternetConnection = '/noInternetConnection';

  static const String home = '/home';
  static const String duels = '/duels';
  static const String addDuel = '/addDuel';
  static const String profile = '/profile';

  static GoRouter getRouter(ScreenFactory screenFactory) => GoRouter(
    initialLocation: AppRouter.home,
    navigatorKey: parentNavigatorKey,
    redirect: (context, state) {
      final isOffline = context.read<ConnectivityCubit>().state.isOffline;

      // In order to not redirect on the same route
      if (isOffline) {
        return noInternetConnection;
      } else {
        return null;
      }
    },
    routes: <RouteBase>[
      ShellRoute(
        parentNavigatorKey: parentNavigatorKey,
        navigatorKey: _shellNavigatorKey,
        pageBuilder:
            (context, state, child) => NoTransitionPage(
              child: screenFactory.mainScreen(context, state, child),
            ),
        routes: [
          GoRoute(
            path: AppRouter.home,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder:
                (context, state) => NoTransitionPage(
                  child: screenFactory.homeScreen(context, state),
                ),
          ),
          GoRoute(
            path: AppRouter.duels,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder:
                (context, state) => NoTransitionPage(
                  child: screenFactory.duelsScreen(context, state),
                ),
          ),
          GoRoute(
            path: AppRouter.addDuel,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder:
                (context, state) => NoTransitionPage(
                  child: screenFactory.addDuelScreen(context, state),
                ),
          ),
          GoRoute(
            path: AppRouter.profile,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder:
                (context, state) => NoTransitionPage(
                  child: screenFactory.profileScreen(context, state),
                ),
          ),
        ],
      ),

      GoRoute(
        path: AppRouter.noInternetConnection,
        pageBuilder:
            (context, state) => NoTransitionPage(
              child: screenFactory.noInternetConnectionScreen(context, state),
            ),
      ),
    ],
  );
}
