import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';

import 'database.dart';

void initLog({LogLevel? level}) => Loggy.initLoggy(
      logPrinter: StreamPrinter(const PrettyPrinter(showColors: true)),
      logOptions: LogOptions(
        level ?? log.level_,
        stackTraceLevel: log.stackTraceLevel_,
        includeCallerInfo: log.includeCallerInfo,
      ),
    );

mixin L implements LoggyType {
  @override
  Loggy<L> get loggy => throw UnsupportedError('Use `l` instead of `loggy`.');

  Loggy<L> get l => Loggy<L>('$runtimeType');
}
