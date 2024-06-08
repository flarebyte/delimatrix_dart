import 'package:flutter_test/flutter_test.dart';

import 'package:delimatrix_dart/dx_result.dart';

void main() {
  group('DxResult.map', () {
    test('maps a DxSuccess result correctly', () {
      const DxResult<int> successResult = DxSuccess(42);
      final DxResult<String> mappedResult = successResult.map((value) => 'Value: $value');

      expect(mappedResult, isA<DxSuccess<String>>());
      expect((mappedResult as DxSuccess<String>).value, 'Value: 42');
    });

    test('preserves a DxFailure result', () {
      const DxResult<int> failureResult = DxFailure('404', 'Not Found');
      final DxResult<String> mappedResult = failureResult.map((value) => 'Value: $value');

      expect(mappedResult, isA<DxFailure>());
      expect((mappedResult as DxFailure).id, '404');
      expect(mappedResult.message, 'Not Found');
    });
  });
}