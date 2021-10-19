import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_size/window_size.dart';

import 'home/home_view.dart';
import 'settings/theme.dart';
import 'utils/database.dart';
import 'utils/log.dart';
import 'utils/sentry.dart';
import 'utils/string.dart';

void main() async {
  await initDatabase();
  Settings.init();
  initLog();
  if (GetPlatform.isDesktop && !GetPlatform.isWeb) initDesktop();
  await initMessages();
  updateUser();
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
      theme: appTheme,
    );
  }
}

void initDesktop() {
  logDebug('initDesktop begin.');

  logDebug('ensureInitialized');
  WidgetsFlutterBinding.ensureInitialized();

  logDebug('setWindowTitle');
  setWindowTitle(appName);

  logDebug('setWindowMinSize');
  setWindowMinSize(const Size(512, 512));

  logInfo('initDesktop end.');
}
