import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'logger.dart';
import 'messages.dart';

Future<void> initSentry(Widget app) async {
  final id = Settings.getValue('id', null);
  final username = Settings.getValue('username', null);
  logger.i('id: $id, username: $username');

  Sentry.configureScope(
    (scope) => scope.user =
        SentryUser(id: id, username: username, ipAddress: '{{auto}}'),
  );

  await SentryFlutter.init(
    (options) {
      options
        ..dsn =
            'https://ca1d394e0da94a11a1c32d650b781ea0@o996799.ingest.sentry.io/5975191'
        ..sendDefaultPii = true
        ..release = '$packageName@$version+$buildNumber';
    },
    appRunner: () => runApp(app),
  );
}
