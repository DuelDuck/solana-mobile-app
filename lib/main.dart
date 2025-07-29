import 'package:duelduck_solana/bloc/auth_cubit/auth_cubit.dart';
import 'package:duelduck_solana/injector/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:duelduck_solana/bloc/connectivity_cubit/connectivity_cubit.dart';
import 'package:duelduck_solana/ui/screen_factory.dart';
import 'package:duelduck_solana/ui/screens/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Injector().register();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'EN')],
      path: 'l10n',
      fallbackLocale: const Locale('en', 'EN'),

      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ConnectivityCubit()),
          BlocProvider<AuthCubit>(
            create: (BuildContext context) => AuthCubit(),
          ),
        ],
        child: MyApp(screenFactory: ScreenFactory()),
      ),
    ),
  );
}
