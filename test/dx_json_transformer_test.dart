import 'dart:convert';

import 'package:delimatrix_dart/dx_json_transformer.dart';
import 'package:delimatrix_dart/dx_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ListToJsonTransformer', () {
    test('transforms List<String> to JSON String', () {
      final transformer = ListToJsonTransformer();

      const DxResult<List<String>> input = DxSuccess(['foo', 'bar']);
      final DxResult<String> result = transformer.transform(input);

      expect(result, isA<DxSuccess<String>>());
      expect((result as DxSuccess<String>).value, jsonEncode(['foo', 'bar']));
    });

    test('handles failure correctly', () {
      final transformer = ListToJsonTransformer();

      const DxResult<List<String>> input = DxFailure('404', 'Not Found');
      final DxResult<String> result = transformer.transform(input);

      expect(result, isA<DxFailure>());
      expect((result as DxFailure).id, '404');
      expect(result.message, 'Not Found');
    });
  });

  group('JsonToListTransformer', () {
    test('transforms JSON String to List<String>', () {
      final transformer = JsonToListTransformer();

      final DxResult<String> input = DxSuccess(jsonEncode(['foo', 'bar']));
      final DxResult<List<String>> result = transformer.transform(input);

      expect(result, isA<DxSuccess<List<String>>>());
      expect((result as DxSuccess<List<String>>).value, ['foo', 'bar']);
    });

    test('handles invalid JSON correctly', () {
      final transformer = JsonToListTransformer();

      const DxResult<String> input = DxSuccess('invalid json');
      final DxResult<List<String>> result = transformer.transform(input);

      expect(result, isA<DxFailure>());
    });

    test('handles failure correctly', () {
      final transformer = JsonToListTransformer();

      const DxResult<String> input = DxFailure('404', 'Not Found');
      final DxResult<List<String>> result = transformer.transform(input);

      expect(result, isA<DxFailure>());
      expect((result as DxFailure).id, '404');
      expect(result.message, 'Not Found');
    });
  });

  group('Chained Transformers', () {
    test('chains ListToJsonTransformer and JsonToListTransformer', () {
      final transformer =
          ListToJsonTransformer().chain(JsonToListTransformer());

      const DxResult<List<String>> input = DxSuccess(['foo', 'bar']);
      final DxResult<List<String>> result = transformer.transform(input);

      expect(result, isA<DxSuccess<List<String>>>());
      expect((result as DxSuccess<List<String>>).value, ['foo', 'bar']);
    });
  });
  group('MapToJsonTransformer', () {
    test('transforms Map<String, String> to JSON String', () {
      final transformer = MapToJsonTransformer();

      const DxResult<Map<String, String>> input = DxSuccess({'foo': 'bar'});
      final DxResult<String> result = transformer.transform(input);

      expect(result, isA<DxSuccess<String>>());
      expect((result as DxSuccess<String>).value, jsonEncode({'foo': 'bar'}));
    });

    test('handles failure correctly', () {
      final transformer = MapToJsonTransformer();

      const DxResult<Map<String, String>> input = DxFailure('404', 'Not Found');
      final DxResult<String> result = transformer.transform(input);

      expect(result, isA<DxFailure>());
      expect((result as DxFailure).id, '404');
      expect(result.message, 'Not Found');
    });
  });

  group('JsonToMapTransformer', () {
    test('transforms JSON String to Map<String, String>', () {
      final transformer = JsonToMapTransformer();

      final DxResult<String> input = DxSuccess(jsonEncode({'foo': 'bar'}));
      final DxResult<Map<String, String>> result = transformer.transform(input);

      expect(result, isA<DxSuccess<Map<String, String>>>());
      expect((result as DxSuccess<Map<String, String>>).value, {'foo': 'bar'});
    });

    test('handles invalid JSON correctly', () {
      final transformer = JsonToMapTransformer();

      const DxResult<String> input = DxSuccess('invalid json');
      final DxResult<Map<String, String>> result = transformer.transform(input);

      expect(result, isA<DxFailure>());
      expect((result as DxFailure).id, 'delimatrix:1e7a6573');
      expect(result.message, 'Invalid JSON format');
    });

    test('handles failure correctly', () {
      final transformer = JsonToMapTransformer();

      const DxResult<String> input = DxFailure('404', 'Not Found');
      final DxResult<Map<String, String>> result = transformer.transform(input);

      expect(result, isA<DxFailure>());
      expect((result as DxFailure).id, '404');
      expect(result.message, 'Not Found');
    });
  });

  group('Chained Transformers', () {
    test('chains MapToJsonTransformer and JsonToMapTransformer', () {
      final transformer = MapToJsonTransformer().chain(JsonToMapTransformer());

      const DxResult<Map<String, String>> input = DxSuccess({'foo': 'bar'});
      final DxResult<Map<String, String>> result = transformer.transform(input);

      expect(result, isA<DxSuccess<Map<String, String>>>());
      expect((result as DxSuccess<Map<String, String>>).value, {'foo': 'bar'});
    });
  });
}
