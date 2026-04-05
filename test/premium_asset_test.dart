import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('assets/premiumbg.png is bundled', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final data = await rootBundle.load('assets/premiumbg.png');
    expect(data.lengthInBytes, greaterThan(0));
  });
}
