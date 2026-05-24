import 'dart:io';

import 'package:check/main.dart';
import 'package:check/returned_data.dart';

void main(List<String> arguments) async {
  final ReturnedData data = await check(arguments);

  if (data.statusCode > 99) {
    print(data.statusCode);
  }

  if (data.canFail) {
    exit(data.exitCode);
  }

  exit(0);
}
