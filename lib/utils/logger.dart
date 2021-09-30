import 'package:logger/logger.dart';

final logger = Logger(printer: PrettyPrinter(lineLength: 84, printTime: true));

void initLogger() => Logger.level = Level.info;
