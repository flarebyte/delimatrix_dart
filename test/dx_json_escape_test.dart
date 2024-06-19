import 'package:delimatrix_dart/delimatrix.dart';
import 'package:test/test.dart';

void main() {
  String asciiString = '';
  for (int codePoint = 0x0020; codePoint <= 0x007E; codePoint++) {
    asciiString += String.fromCharCode(codePoint);
  }

  // Shavian range
  String shavianString = '';
  for (int codePoint = 0x10450; codePoint <= 0x1047F; codePoint++) {
    shavianString += String.fromCharCode(codePoint);
  }

  // Linear B Syllabary range
  String linearBString = '';
  for (int codePoint = 0x10000; codePoint <= 0x1007F; codePoint++) {
    linearBString += String.fromCharCode(codePoint);
  }

  group('JsonEscapeConfigBuilder', () {
    test('should build JsonEscapeConfig with default values', () {
      final config = JsonEscapeConfig.builder().build();

      expect(config.doubleQuote, equals('"'));
      expect(config.backslash, equals('\\'));
    });

    test('should set and build JsonEscapeConfig with custom values', () {
      final config = JsonEscapeConfig.builder()
          .setDoubleQuote('*')
          .setBackslash('#')
          .build();

      expect(config.doubleQuote, equals('*'));
      expect(config.backslash, equals('#'));
    });

    test('should allow setting only some values and use defaults for others',
        () {
      final config = JsonEscapeConfig.builder().setDoubleQuote('*').build();

      expect(config.doubleQuote, equals('*'));
      expect(config.backslash, equals('\\'));
    });
  });
  group('ToDxJsonTransformer and FromDxJsonTransformer Tests', () {
    test('Shavian Transformation with JSON payload', () {
      const DxResult<String> input = DxSuccess(
          '{"key": "value with special chars: " \n \r \t \b \f / 🙂"}');
      ToDxJsonTransformer toTransformer =
          ToDxJsonTransformer(JsonEscapeConfigs.shavian);
      FromDxJsonTransformer fromTransformer =
          FromDxJsonTransformer(JsonEscapeConfigs.shavian);

      DxResult<String> transformed = toTransformer.transform(input);
      DxResult<String> reverted = fromTransformer.transform(transformed);
      expect(reverted.value, equals(input.value));
    });

    test('Shavian Transformation with CSV payload', () {
      const DxResult<String> input = DxSuccess(
          'key1, key2, "value with, comma", "value with \\"quotes\\""');
      ToDxJsonTransformer toTransformer =
          ToDxJsonTransformer(JsonEscapeConfigs.shavian);
      FromDxJsonTransformer fromTransformer =
          FromDxJsonTransformer(JsonEscapeConfigs.shavian);

      DxResult<String> transformed = toTransformer.transform(input);
      DxResult<String> reverted = fromTransformer.transform(transformed);

      expect(reverted.value, equals(input.value));
    });

    test('Shavian Transformation with String payload', () {
      const DxResult<String> input = DxSuccess(
          'This is a simple string with special chars: " \n \r \t \b \f / 🙂');
      ToDxJsonTransformer toTransformer =
          ToDxJsonTransformer(JsonEscapeConfigs.shavian);
      FromDxJsonTransformer fromTransformer =
          FromDxJsonTransformer(JsonEscapeConfigs.shavian);

      DxResult<String> transformed = toTransformer.transform(input);
      DxResult<String> reverted = fromTransformer.transform(transformed);

      expect(reverted.value, equals(input.value));
    });

    test('Shavian Transformation with ASCII and LinearB payload', () {
      final DxResult<String> input = DxSuccess('$asciiString $linearBString');
      ToDxJsonTransformer toTransformer =
          ToDxJsonTransformer(JsonEscapeConfigs.shavian);
      FromDxJsonTransformer fromTransformer =
          FromDxJsonTransformer(JsonEscapeConfigs.shavian);

      DxResult<String> transformed = toTransformer.transform(input);
      DxResult<String> reverted = fromTransformer.transform(transformed);
      expect(reverted.value, equals(input.value));
    });

    test('Shavian Transformation with unwanted payload', () {
      final DxResult<String> input = DxSuccess(
          'text with shavian in it already ${JsonEscapeConfigs.shavian.doubleQuote}');
      ToDxJsonTransformer toTransformer =
          ToDxJsonTransformer(JsonEscapeConfigs.shavian);

      DxResult<String> transformed = toTransformer.transform(input);
      expect(transformed, isA<DxFailure>());
      expect((transformed as DxFailure).id, 'delimatrix:199fdd19');
      expect(transformed.message, 'Special chars already in payload');
    });

    test('Linear B Transformation with JSON payload', () {
      const DxResult<String> input = DxSuccess(
          '{"key": "value with special chars: " \n \r \t \b \f / 🙂"}');
      ToDxJsonTransformer toTransformer =
          ToDxJsonTransformer(JsonEscapeConfigs.linearB);
      FromDxJsonTransformer fromTransformer =
          FromDxJsonTransformer(JsonEscapeConfigs.linearB);

      DxResult<String> transformed = toTransformer.transform(input);
      DxResult<String> reverted = fromTransformer.transform(transformed);

      expect(reverted.value, equals(input.value));
    });

    test('Linear B Transformation with CSV payload', () {
      const DxResult<String> input = DxSuccess(
          'key1, key2, "value with, comma", "value with \\"quotes\\""');
      ToDxJsonTransformer toTransformer =
          ToDxJsonTransformer(JsonEscapeConfigs.linearB);
      FromDxJsonTransformer fromTransformer =
          FromDxJsonTransformer(JsonEscapeConfigs.linearB);

      DxResult<String> transformed = toTransformer.transform(input);
      DxResult<String> reverted = fromTransformer.transform(transformed);

      expect(reverted.value, equals(input.value));
    });

    test('Linear B Transformation with String payload', () {
      const DxResult<String> input = DxSuccess(
          'This is a simple string with special chars: " \n \r \t \b \f / 🙂');
      ToDxJsonTransformer toTransformer =
          ToDxJsonTransformer(JsonEscapeConfigs.linearB);
      FromDxJsonTransformer fromTransformer =
          FromDxJsonTransformer(JsonEscapeConfigs.linearB);

      DxResult<String> transformed = toTransformer.transform(input);
      DxResult<String> reverted = fromTransformer.transform(transformed);

      expect(reverted.value, equals(input.value));
    });

    test('Linear B Transformation with ASCII and Shavian payload', () {
      final DxResult<String> input = DxSuccess('$asciiString $shavianString');
      ToDxJsonTransformer toTransformer =
          ToDxJsonTransformer(JsonEscapeConfigs.linearB);
      FromDxJsonTransformer fromTransformer =
          FromDxJsonTransformer(JsonEscapeConfigs.linearB);

      DxResult<String> transformed = toTransformer.transform(input);
      DxResult<String> reverted = fromTransformer.transform(transformed);

      expect(reverted.value, equals(input.value));
    });
  });
}
