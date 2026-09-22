import 'dart:io';

import 'package:integration_test/integration_test_driver_extended.dart';

Future<void> main() async {
  final adb = Platform.isWindows
      ? '${Platform.environment['LOCALAPPDATA']}\\Android\\Sdk\\platform-tools\\adb.exe'
      : 'adb';
  const remote = '/sdcard/CS-Coders-Demo.mp4';
  final recording = await Process.start(adb, [
    'shell',
    'screenrecord',
    '--time-limit',
    '30',
    remote,
  ]);
  try {
    await integrationDriver();
  } finally {
    await Process.run(adb, ['shell', 'pkill', '-2', 'screenrecord']);
    await recording.exitCode;
    final pull = await Process.run(adb, [
      'pull',
      remote,
      'evidence/CS-Coders-Demo.mp4',
    ]);
    if (pull.exitCode != 0) {
      stderr.write(pull.stderr);
    }
  }
}
