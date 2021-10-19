import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'database.dart';
import 'string.dart';

void updateUser() {
  logInfo('id: ${user.id}, username: ${user.name}');
  Sentry.configureScope(
    (scope) => scope.user = SentryUser(
      id: user.id,
      username: user.name,
      ipAddress: '{{auto}}',
    ),
  );
}

Future<void> initSentry(Widget app) async {
  logInfo('release: $release');
  await SentryFlutter.init(
    (options) => options
      ..dsn =
          'https://ca1d394e0da94a11a1c32d650b781ea0@o996799.ingest.sentry.io/5975191'
      ..tracesSampleRate = 1
      ..sendDefaultPii = true
      ..release = release,
    appRunner: () => runApp(app),
  );
}
