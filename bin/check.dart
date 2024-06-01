import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart';

import 'returned_data.dart';

const String version = '0.0.3';

///
///
///
enum Method { head, get, post, put, patch, delete }

///
///
///
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
    ..addOption(
      'content-type',
      help: 'Set the content type for the request.',
      defaultsTo: 'application/json',
      valueHelp: 'type',
    )
    ..addOption(
      'user-agent',
      help: 'Set the user agent for the request.',
      defaultsTo: 'check/$version',
      valueHelp: 'agent',
    )
    ..addFlag(
      'fail',
      help: 'Fail on non-200 status code.',
      defaultsTo: true,
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
Future<ReturnedData> check(List<String> arguments) async {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false;
    Method method = Method.get;
    int urlPos = 0;
    Duration timeout = const Duration(seconds: 10);

    if (results.wasParsed('help')) {
      printUsage(argParser);
      return ReturnedData.empty();
    }

    if (results.wasParsed('version')) {
      print('check version: $version');
      return ReturnedData.empty();
    }

    if (results.wasParsed('verbose')) {
      verbose = true;
    }

    if (results.wasParsed('timeout')) {
      try {
        final int value = int.parse(results['timeout']);
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
      throw const FormatException('No URL provided.');
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
      throw const FormatException('No URL provided.');
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

    final Map<String, String> headers = <String, String>{
      'User-Agent': results['user-agent'],
      'Content-Type': results['content-type'],
    };

    Response response;

    switch (method) {
      case Method.head:
        if (verbose) {
          print('[VERBOSE] HEAD: $uri');
        }
        response = await head(uri, headers: headers).timeout(timeout);
      case Method.get:
        if (verbose) {
          print('[VERBOSE] GET: $uri');
        }
        response = await get(uri, headers: headers).timeout(timeout);
      case Method.post:
        if (verbose) {
          print('[VERBOSE] POST: $uri');
        }
        response = await post(uri, headers: headers).timeout(timeout);
      case Method.put:
        if (verbose) {
          print('[VERBOSE] PUT: $uri');
        }
        response = await put(uri, headers: headers).timeout(timeout);
      case Method.patch:
        if (verbose) {
          print('[VERBOSE] PATCH: $uri');
        }
        response = await patch(uri, headers: headers).timeout(timeout);
      case Method.delete:
        if (verbose) {
          print('[VERBOSE] DELETE: $uri');
        }
        response = await delete(uri, headers: headers).timeout(timeout);
    }

    final int code = response.statusCode;

    if (verbose) {
      print('[VERBOSE] Status code: $code');
    }

    int exitCode;

    if (code < 199) {
      exitCode = 9;
    } else if (code >= 200 && code < 300) {
      exitCode = 0;
    } else if (code >= 545) {
      exitCode = 255;
    } else {
      exitCode = code - 290;
    }

    return ReturnedData(
      exitCode: exitCode,
      statusCode: code,
      canFail: results['fail'],
    );
  } on FormatException catch (e) {
    print('');
    print(e.message);
    print('');
    printUsage(argParser);
    return ReturnedData(exitCode: 1, statusCode: 0, canFail: true);
  } on Exception catch (e) {
    print('');
    print(e);
    print('');
    return ReturnedData(exitCode: 7, statusCode: 0, canFail: true);
  } on Error catch (e) {
    print('');
    print(e);
    print('');
    return ReturnedData(exitCode: 8, statusCode: 0, canFail: true);
  }
}
