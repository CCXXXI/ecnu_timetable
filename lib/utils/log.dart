import 'package:loggy/loggy.dart';

void initLog() => Loggy.initLoggy(
      logPrinter: const PrettyPrinter(showColors: true),
      logOptions: const LogOptions(LogLevel.debug),
    );

mixin L implements LoggyType {
  @override
  Loggy<L> get loggy => throw UnsupportedError('Use `l` instead of `loggy`.');

  Loggy<L> get l => Loggy<L>('$runtimeType');
}
