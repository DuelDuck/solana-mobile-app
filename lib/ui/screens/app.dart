import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';

import 'package:duelduck_solana/bloc/connectivity_cubit/connectivity_cubit.dart';
import 'package:duelduck_solana/ui/screen_factory.dart';
import 'package:duelduck_solana/ui/screens/routing.dart';
import 'package:duelduck_solana/utils/constants.dart';

class MyApp extends StatefulWidget {
  final ScreenFactory screenFactory;

  const MyApp({super.key, required this.screenFactory});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter router;

  @override
  void initState() {
    super.initState();

    router = AppRouter.getRouter(widget.screenFactory);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConnectivityCubit, ConnectivityState>(
          listenWhen:
              (previous, current) => previous.isOffline != current.isOffline,
          listener: (context, state) {
            if (state.isOffline) {
              router.push(AppRouter.noInternetConnection);
            } else {
              if (router.canPop()) {
                router.pop();
              }
            }
          },
        ),
      ],

      child: ToastificationConfigProvider(
        config: ToastificationConfig(
          maxToastLimit: 1,
          alignment: Alignment.bottomCenter,
          marginBuilder: (context, alignment) {
            return EdgeInsets.only(bottom: 100);
          },
        ),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: themeData,
        ),
      ),
    );
  }
}
