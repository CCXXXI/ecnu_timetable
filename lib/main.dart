import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_size/window_size.dart';

import 'home/home_view.dart';
import 'settings/theme.dart';
import 'utils/log.dart';
import 'utils/messages.dart';

void main() async {
  initLog();
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

void initDesktop() {
  logDebug('initDesktop begin.');

  logDebug('ensureInitialized');
  WidgetsFlutterBinding.ensureInitialized();

  logDebug('setWindowTitle');
  setWindowTitle(appName);

  logDebug('setWindowMinSize');
  setWindowMinSize(const Size(300, 400));

  logInfo('initDesktop end.');
}

Future<void> initSentry(Widget app) async {
  final id = Settings.getValue('id', null);
  final username = Settings.getValue('username', null);
  logInfo('id: $id, username: $username');
  logInfo('release: $release');

  Sentry.configureScope((scope) => scope.user =
      SentryUser(id: id, username: username, ipAddress: '{{auto}}'));

  await SentryFlutter.init(
    (options) {
      options
        ..dsn =
            'https://ca1d394e0da94a11a1c32d650b781ea0@o996799.ingest.sentry.io/5975191'
        ..sendDefaultPii = true
        ..release = release;
    },
    appRunner: () => runApp(app),
  );
}
