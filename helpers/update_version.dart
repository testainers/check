import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Error: No version provided.');
    exit(1);
  }

  final String version = args.first;
  final File file = File('lib/main.dart');

  if (!file.existsSync()) {
    print('Error: File not found: ${file.path}');
    exit(1);
  }

  String content = file.readAsStringSync();

  final RegExp regex = RegExp(r"const String version = 'dev';");
  content = content.replaceAll(regex, "const String version = '$version';");

  file.writeAsStringSync(content);
  print('Version updated to $version in lib/main.dart!');
}