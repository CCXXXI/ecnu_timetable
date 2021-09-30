import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'home/home_view.dart';
import 'utils/desktop.dart';
import 'utils/logger.dart';
import 'utils/messages.dart';

Future<void> main() async {
  initLogger();
  if (GetPlatform.isDesktop) initDesktop();

  // todo: more user info
  // todo: clear the currently set user when logout
  Sentry.configureScope(
    (scope) => scope.user = SentryUser(
      id: null,
      username: null,
      ipAddress: '{{auto}}',
    ),
  );

  await SentryFlutter.init(
    (options) {
      options
        ..dsn =
            'https://ca1d394e0da94a11a1c32d650b781ea0@o996799.ingest.sentry.io/5975191'
        ..sendDefaultPii = true
        ..release = '$packageName@$version+$buildNumber';
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorObservers: [SentryNavigatorObserver()],
      title: appName,
      home: HomePage(),
    );
  }
}
