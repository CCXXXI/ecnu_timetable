import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:window_size/window_size.dart';

import 'messages.dart';

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
