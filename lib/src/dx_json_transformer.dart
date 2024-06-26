import 'dart:convert';

import 'dx_result.dart';
import 'dx_transformer.dart';

/// Transformer to convert List<String> to JSON String
class ListToJsonTransformer extends DxTransformer<List<String>, String> {
  @override
  DxResult<String> transform(DxResult<List<String>> input) {
    return input.map((value) => jsonEncode(value));
  }
}

/// Transformer to convert JSON String to List<String>
class JsonToListTransformer extends DxTransformer<String, List<String>> {
  @override
  DxResult<List<String>> transform(DxResult<String> input) {
    try {
      return input.map((value) => List<String>.from(jsonDecode(value)));
    } catch (e) {
      return const DxFailure('delimatrix:97f9fa4c', 'Invalid JSON format');
    }
  }
}

/// Transformer to convert Map<String, String> to JSON String
class MapToJsonTransformer extends DxTransformer<Map<String, String>, String> {
  @override
  DxResult<String> transform(DxResult<Map<String, String>> input) {
    return input.map((value) => jsonEncode(value));
  }
}

/// Transformer to convert JSON String to Map<String, String>
class JsonToMapTransformer extends DxTransformer<String, Map<String, String>> {
  @override
  DxResult<Map<String, String>> transform(DxResult<String> input) {
    try {
      return input.map((value) => Map<String, String>.from(jsonDecode(value)));
    } catch (e) {
      return const DxFailure('delimatrix:1e7a6573', 'Invalid JSON format');
    }
  }
}

/// Static class to hold transformer instances
class JsonTransformers {
  static final ListToJsonTransformer fromList = ListToJsonTransformer();
  static final JsonToListTransformer toList = JsonToListTransformer();
  static final MapToJsonTransformer fromMap = MapToJsonTransformer();
  static final JsonToMapTransformer toMap = JsonToMapTransformer();
}
