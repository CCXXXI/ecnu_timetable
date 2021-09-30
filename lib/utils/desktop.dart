import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import 'logger.dart';
import 'messages.dart';

void initDesktop() {
  logger.i('initDesktop...');

  logger.i('ensureInitialized');
  WidgetsFlutterBinding.ensureInitialized();

  logger.i('setWindowTitle');
  setWindowTitle(appName);

  logger.i('setWindowMinSize');
  setWindowMinSize(const Size(300, 300));

  logger.i('Done.');
}
