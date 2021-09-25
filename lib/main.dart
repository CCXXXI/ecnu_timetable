import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:sentry_flutter/sentry_flutter.dart';

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
    return GetMaterialApp(
      navigatorObservers: [
        SentryNavigatorObserver(),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Placeholder(),
    );
  }
}
