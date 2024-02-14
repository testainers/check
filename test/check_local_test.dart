import 'package:test/test.dart';
import 'package:testainers/testainers.dart';

import '../bin/check.dart';
import '../bin/returned_data.dart';

///
///
///
void main() {
  ///
  ///
  ///
  group('basic tests', () {
    final TestainersHttpbucket container = TestainersHttpbucket();

    ///
    setUpAll(() async {
      await container.start();
    });

    ///
    test('Root Get', () async {
      expect(
        await check(<String>[':${container.httpPort}']),
        ReturnedData.ok(),
      );
    });

    ///
    test('Method GET', () async {
      expect(
        await check(<String>[':${container.httpPort}/methods']),
        ReturnedData.ok(),
      );
    });

    ///
    test('Method HEAD', () async {
      expect(
        await check(<String>['HEAD', ':${container.httpPort}/methods']),
        ReturnedData.ok(),
      );
    });

    ///
    test('Method POST', () async {
      expect(
        await check(<String>['POST', ':${container.httpPort}/methods']),
        ReturnedData.ok(),
      );
    });

    ///
    test('Method PUT', () async {
      expect(
        await check(<String>['PUT', ':${container.httpPort}/methods']),
        ReturnedData.ok(),
      );
    });

    ///
    test('Method PATCH', () async {
      expect(
        await check(<String>['PATCH', ':${container.httpPort}/methods']),
        ReturnedData.ok(),
      );
    });

    ///
    test('Method DELETE', () async {
      expect(
        await check(<String>['DELETE', ':${container.httpPort}/methods']),
        ReturnedData.ok(),
      );
    });

    ///
    test('Status GET 200', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/200']),
        ReturnedData.ok(),
      );
    });

    ///
    test('Status GET 201', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/201']),
        ReturnedData.created(),
      );
    });

    ///
    test('Status GET 202', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/202']),
        ReturnedData.accepted(),
      );
    });

    ///
    test('Status GET 204', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/204']),
        ReturnedData.noContent(),
      );
    });

    ///
    test('Status GET 300', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/300']),
        ReturnedData.multipleChoices(),
      );
    });

    ///
    test('Status GET 300 no Fail', () async {
      expect(
        await check(<String>['--no-fail', ':${container.httpPort}/status/300']),
        ReturnedData.multipleChoices(canFail: false),
      );
    });

    ///
    test('Status GET 300', () async {
      expect(
        await check(<String>['--no-fail', ':${container.httpPort}/status/300']),
        ReturnedData.multipleChoices(canFail: false),
      );
    });

    ///
    test('Status GET 389', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/389']),
        ReturnedData(statusCode: 389, exitCode: 99, canFail: true),
      );
    });

    ///
    test('Status GET 390', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/390']),
        ReturnedData(statusCode: 390, exitCode: 100, canFail: true),
      );
    });

    ///
    test('Status GET 399', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/399']),
        ReturnedData(statusCode: 399, exitCode: 109, canFail: true),
      );
    });

    ///
    test('Status GET 400', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/400']),
        ReturnedData.badRequest(),
      );
    });

    ///
    test('Status GET 400 no Fail', () async {
      expect(
        await check(<String>['--no-fail', ':${container.httpPort}/status/400']),
        ReturnedData.badRequest(canFail: false),
      );
    });

    ///
    test('Status GET 401', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/401']),
        ReturnedData.unauthorized(),
      );
    });

    ///
    test('Status GET 403', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/403']),
        ReturnedData.forbidden(),
      );
    });

    ///
    test('Status GET 404', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/404']),
        ReturnedData.notFound(),
      );
    });

    ///
    test('Status GET 500', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/500']),
        ReturnedData.serverError(),
      );
    });

    ///
    test('Status GET 500 no Fail', () async {
      expect(
        await check(<String>['--no-fail', ':${container.httpPort}/status/500']),
        ReturnedData.serverError(canFail: false),
      );
    });

    ///
    test('Status GET 544', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/544']),
        ReturnedData(statusCode: 544, exitCode: 254, canFail: true),
      );
    });

    ///
    test('Status GET 545', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/545']),
        ReturnedData(statusCode: 545, exitCode: 255, canFail: true),
      );
    });

    ///
    test('Status GET 546', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/546']),
        ReturnedData(statusCode: 546, exitCode: 255, canFail: true),
      );
    });

    ///
    test('Status GET 599', () async {
      expect(
        await check(<String>[':${container.httpPort}/status/599']),
        ReturnedData(statusCode: 599, exitCode: 255, canFail: true),
      );
    });

    ///
    test('Status GET 599 no Fail', () async {
      expect(
        await check(<String>['--no-fail', ':${container.httpPort}/status/599']),
        ReturnedData(statusCode: 599, exitCode: 255, canFail: false),
      );
    });

    ///
    tearDownAll(container.stop);
  });
}
