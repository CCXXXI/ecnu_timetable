import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';

import 'database.dart';

void initLog() => Loggy.initLoggy(
      logPrinter: StreamPrinter(const PrettyPrinter(showColors: true)),
      logOptions: LogOptions(
        log.level_,
        stackTraceLevel: log.stackTraceLevel_,
        includeCallerInfo: log.includeCallerInfo,
      ),
    );

mixin L implements LoggyType {
  @override
  Loggy<L> get loggy => throw UnsupportedError('Use `l` instead of `loggy`.');

  Loggy<L> get l => Loggy<L>('$runtimeType');
}
