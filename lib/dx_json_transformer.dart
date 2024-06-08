library delimatrix_dart;

import 'dart:convert';

import 'dx_result.dart';
import 'dx_transformer.dart';

// Transformer to convert List<String> to JSON String
class ListToJsonTransformer extends DxTransformer<List<String>, String> {
  @override
  DxResult<String> transform(DxResult<List<String>> input) {
    return input.map((value) => jsonEncode(value));
  }
}

// Transformer to convert JSON String to List<String>
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