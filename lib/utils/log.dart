import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';

import 'database.dart';

void initLog({
  LogLevel? level,
  LogLevel? stackTraceLevel,
  bool? includeCallerInfo,
}) =>
    Loggy.initLoggy(
      logPrinter: StreamPrinter(const PrettyPrinter(showColors: true)),
      logOptions: LogOptions(
        level ?? log.level_,
        stackTraceLevel: stackTraceLevel ?? log.stackTraceLevel_,
        includeCallerInfo: includeCallerInfo ?? log.includeCallerInfo,
      ),
    );

mixin L implements LoggyType {
  @override
  Loggy<L> get loggy => throw UnsupportedError('Use `l` instead of `loggy`.');

  Loggy<L> get l => Loggy<L>('$runtimeType');
}
