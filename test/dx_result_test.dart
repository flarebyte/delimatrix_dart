import 'package:delimatrix_dart/delimatrix.dart';
import 'package:test/test.dart';

void main() {
  group('DxResult', () {
    test('isSuccess returns true for DxSuccess', () {
      const result = DxSuccess<int>(42);
      expect(result.isSuccess, true);
      expect(result.isFailure, false);
    });

    test('isFailure returns true for DxFailure', () {
      const result = DxFailure('404', 'Not Found');
      expect(result.isFailure, true);
      expect(result.isSuccess, false);
    });

    test('value returns correct value for DxSuccess', () {
      const result = DxSuccess<String>('Hello');
      expect(result.value, 'Hello');
    });

    test('value returns null for DxFailure', () {
      const result = DxFailure('500', 'Server Error');
      expect(result.value, null);
    });

    test('error returns correct DxFailure for DxFailure', () {
      const result = DxFailure('403', 'Forbidden');
      expect(result.error, isNotNull);
      expect(result.error?.id, '403');
      expect(result.error?.message, 'Forbidden');
    });

    test('error returns null for DxSuccess', () {
      const result = DxSuccess<int>(123);
      expect(result.error, null);
    });
  });
  group('DxResult.map', () {
    test('maps a DxSuccess result correctly', () {
      const DxResult<int> successResult = DxSuccess(42);
      final DxResult<String> mappedResult =
          successResult.map((value) => 'Value: $value');

      expect(mappedResult, isA<DxSuccess<String>>());
      expect((mappedResult as DxSuccess<String>).value, 'Value: 42');
    });

    test('preserves a DxFailure result', () {
      const DxResult<int> failureResult = DxFailure('404', 'Not Found');
      final DxResult<String> mappedResult =
          failureResult.map((value) => 'Value: $value');

      expect(mappedResult, isA<DxFailure>());
      expect((mappedResult as DxFailure).id, '404');
      expect(mappedResult.message, 'Not Found');
    });
  });

  group('DxResult.validate', () {
    test('passes validation for a valid value', () {
      const DxResult<int> result = DxSuccess(42);
      final DxResult<int> validatedResult = result.validate(
          (value) => value > 0, 'NEGATIVE_VALUE', 'Value must be positive');

      expect(validatedResult, isA<DxSuccess<int>>());
      expect((validatedResult as DxSuccess<int>).value, 42);
    });

    test('fails validation for an invalid value', () {
      const DxResult<int> result = DxSuccess(-1);
      final DxResult<int> validatedResult = result.validate(
          (value) => value > 0, 'NEGATIVE_VALUE', 'Value must be positive');

      expect(validatedResult, isA<DxFailure>());
      expect((validatedResult as DxFailure).id, 'NEGATIVE_VALUE');
      expect(validatedResult.message, 'Value must be positive');
    });

    test('returns failure unchanged', () {
      const DxResult<int> result = DxFailure('404', 'Not Found');
      final DxResult<int> validatedResult = result.validate(
          (value) => value > 0, 'NEGATIVE_VALUE', 'Value must be positive');

      expect(validatedResult, isA<DxFailure>());
      expect((validatedResult as DxFailure).id, '404');
      expect(validatedResult.message, 'Not Found');
    });
  });
}
