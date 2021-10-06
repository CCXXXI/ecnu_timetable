import 'package:loggy/loggy.dart';

void initLoggy() => Loggy.initLoggy(
      logPrinter: const PrettyPrinter(showColors: true),
      logOptions: const LogOptions(LogLevel.info),
    );
