import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'home/home_view.dart';
import 'settings/theme.dart';
import 'utils/desktop.dart';
import 'utils/messages.dart';
import 'utils/sentry.dart';

void main() async {
  Loggy.initLoggy(logPrinter: const PrettyPrinter(showColors: true));
  await Settings.init();
  if (GetPlatform.isDesktop && !GetPlatform.isWeb) initDesktop();
  await initMessages();
  await initSentry(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [SentryNavigatorObserver()],
      title: appName,
      home: HomePage(),
      theme: theme,
    );
  }
}
