import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart';

const String version = 'dev';

///
///
///
enum Method { head, get, post, put, delete, patch }

///
///
///
void main(List<String> arguments) async {
  int code = await check(arguments);

  if (code >= 200 && code < 300) {
    exit(0);
  } else {
    exit(code);
  }
}

///
///
///
ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addOption(
      'timeout',
      abbr: 't',
      help: 'Set the timeout for the request.',
      defaultsTo: '10',
      valueHelp: 'in seconds',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag(
      'version',
      negatable: false,
      help: 'Print the tool version.',
    );
}

///
///
///
void printUsage(ArgParser argParser) {
  print('Usage: check <flags> [METHOD] URL');
  print(argParser.usage);
}

///
///
///
Future<int> check(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false;
    Method method = Method.get;
    int urlPos = 0;
    Duration timeout = Duration(seconds: 10);

    if (results.wasParsed('help')) {
      printUsage(argParser);
      return 1;
    }

    if (results.wasParsed('version')) {
      print('check version: $version');
      return 1;
    }

    if (results.wasParsed('verbose')) {
      verbose = true;
    }

    if (results.wasParsed('timeout')) {
      try {
        int value = int.parse(results['timeout']);
        if (value < 1) {
          throw FormatException('Invalid timeout value: ${results['timeout']}');
        }
        timeout = Duration(seconds: value);
      } on Exception {
        throw FormatException('Invalid timeout value: ${results['timeout']}');
      }
    }

    if (verbose) {
      print('[VERBOSE] Positional arguments: ${results.rest}');
      print('[VERBOSE] All arguments: ${results.arguments}');
    }

    if (results.rest.isEmpty) {
      throw FormatException('No URL provided.');
    }

    try {
      method = Method.values.byName(results.rest.first.toLowerCase());
      urlPos = 1;
    } on Error {
      if (verbose) {
        print('[VERBOSE] Using default method: GET');
      }
    }

    if (verbose) {
      print('[VERBOSE] Method: $method');
    }

    if (results.rest.length <= urlPos) {
      throw FormatException('No URL provided.');
    }

    String url = results.rest[urlPos];

    if (url.startsWith(RegExp(r':\d+'))) {
      url = 'http://localhost$url';
    }

    if (verbose) {
      print('[VERBOSE] URL: $url');
    }

    Uri uri = Uri.parse(url);

    if (uri.scheme.isEmpty) {
      uri = Uri.parse('http://$uri');
    }

    if (verbose) {
      print('[VERBOSE] URI: $uri');
    }

    Response response;

    switch (method) {
      case Method.head:
        if (verbose) {
          print('[VERBOSE] HEAD: $uri');
        }
        response = await head(uri).timeout(timeout);
        break;
      case Method.get:
        if (verbose) {
          print('[VERBOSE] GET: $uri');
        }
        response = await get(uri).timeout(timeout);
        break;
      case Method.post:
        if (verbose) {
          print('[VERBOSE] POST: $uri');
        }
        response = await post(uri).timeout(timeout);
        break;
      case Method.put:
        if (verbose) {
          print('[VERBOSE] PUT: $uri');
        }
        response = await put(uri).timeout(timeout);
        break;
      case Method.delete:
        if (verbose) {
          print('[VERBOSE] DELETE: $uri');
        }
        response = await delete(uri).timeout(timeout);
        break;
      case Method.patch:
        if (verbose) {
          print('[VERBOSE] PATCH: $uri');
        }
        response = await patch(uri).timeout(timeout);
        break;
    }

    int code = response.statusCode;

    if (verbose) {
      print('[VERBOSE] Status code: $code');
    }

    return code;
  } on FormatException catch (e) {
    print('');
    print(e.message);
    print('');
    printUsage(argParser);
    return 0;
  } on Exception catch (e) {
    print('');
    print(e);
    print('');
    return 1;
  }
}
