import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:loggy/loggy.dart';

void initLog({LogLevel? level}) => Loggy.initLoggy(
      logPrinter: StreamPrinter(const PrettyPrinter(showColors: true)),
      logOptions: LogOptions(
        level ?? LogLevel.values[Settings.getValue('log.level', 2)],
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
