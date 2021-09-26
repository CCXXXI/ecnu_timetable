import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:window_size/window_size.dart';

import 'home/home_view.dart';
import 'utils/messages.dart';

Future<void> main() async {
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
        ..sendDefaultPii = true;
    },
    appRunner: () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/a/66181947/13805358
    if (GetPlatform.isDesktop) {
      logger.i('The platform is desktop.');

      logger.i('Set window title.');
      setWindowTitle('ECNU Timetable'.t);

      logger.i('Set window min size.');
      setWindowMinSize(const Size(300, 300));
    }

    return GetMaterialApp(
      navigatorObservers: [SentryNavigatorObserver()],
      title: 'ECNU Timetable'.t,
      home: HomePage(),
    );
  }
}

final logger = Logger(printer: PrettyPrinter(lineLength: 94));
