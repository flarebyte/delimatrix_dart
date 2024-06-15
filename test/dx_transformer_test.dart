import 'package:delimatrix_dart/delimatrix_dart.dart';
import 'package:test/test.dart';

class IntToStringTransformer extends DxTransformer<int, String> {
  @override
  DxResult<String> transform(DxResult<int> input) {
    return input.map((value) => 'Value: $value');
  }
}

class StringToLengthTransformer extends DxTransformer<String, int> {
  @override
  DxResult<int> transform(DxResult<String> input) {
    return input.map((value) => value.length);
  }
}

void main() {
  group('DxTransformer.chain', () {
    test('chains two transformers correctly', () {
      final transformer =
          IntToStringTransformer().chain(StringToLengthTransformer());

      const DxResult<int> input = DxSuccess(42);
      final DxResult<int> result = transformer.transform(input);

      expect(result, isA<DxSuccess<int>>());
      expect((result as DxSuccess<int>).value, 'Value: 42'.length);
    });

    test('chains three transformers correctly', () {
      final transformer = IntToStringTransformer()
          .chain(StringToLengthTransformer())
          .chain(IntToStringTransformer());

      const DxResult<int> input = DxSuccess(42);
      final DxResult<String> result = transformer.transform(input);

      expect(result, isA<DxSuccess<String>>());
      expect((result as DxSuccess<String>).value, 'Value: 9');
    });

    test('handles failure in chained transformers', () {
      final transformer =
          IntToStringTransformer().chain(StringToLengthTransformer());

      const DxResult<int> input = DxFailure('404', 'Not Found');
      final DxResult<int> result = transformer.transform(input);

      expect(result, isA<DxFailure>());
      expect((result as DxFailure).id, '404');
      expect(result.message, 'Not Found');
    });
  });
}
