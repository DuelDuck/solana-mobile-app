import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:duelduck_solana/ui/screens/main_screen/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en', 'EN')],
      path: 'l10n',
      fallbackLocale: const Locale('en', 'EN'),
      child: MyApp(),
    ),
  );
}
