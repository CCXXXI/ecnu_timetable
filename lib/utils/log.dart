import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:loggy/loggy.dart';

void initLog() => Loggy.initLoggy(
      logPrinter: const PrettyPrinter(showColors: true),
      logOptions: LogOptions(
        LogLevel.values[Settings.getValue('log.level', 0)],
        stackTraceLevel:
            LogLevel.values[Settings.getValue('log.stackTraceLevel', 5)],
        includeCallerInfo: Settings.getValue('log.includeCallerInfo', false),
      ),
    );

mixin L implements LoggyType {
  @override
  Loggy<L> get loggy => throw UnsupportedError('Use `l` instead of `loggy`.');

  Loggy<L> get l => Loggy<L>('$runtimeType');
}
