import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';

import 'logger.dart';
import 'messages.dart';

void initDesktop() {
  logger.d('initDesktop begin.');

  logger.d('ensureInitialized');
  WidgetsFlutterBinding.ensureInitialized();

  logger.d('setWindowTitle');
  setWindowTitle(appName);

  logger.d('setWindowMinSize');
  setWindowMinSize(const Size(300, 300));

  logger.i('initDesktop end.');
}
