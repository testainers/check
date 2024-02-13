import 'package:test/test.dart';
import 'package:testainers/testainers.dart';

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
    tearDownAll(() {
      container.stop();
    });
  });
}
