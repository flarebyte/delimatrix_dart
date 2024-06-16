# Usage

## Convert back and forth Map\<String, String> to Delimatrix style JSON

```dart
final fromMap = JsonTransformers.fromMap
      .chain(ToDxJsonTransformer(JsonEscapeConfigs.shavian));

  final toMap = FromDxJsonTransformer(JsonEscapeConfigs.shavian)
      .chain(JsonTransformers.toMap);

  const DxResult<Map<String, String>> input = DxSuccess({'foo': 'bar'});

  // Convert a Map<String, String> to Delimatrix style JSON
  final jsonishStringResult = fromMap.transform(input);
  print(jsonishStringResult.value);
  // {𐑣foo𐑣:𐑣bar𐑣}

  // Convert Delimatrix style JSON back to  Map<String, String>
  final mapResult = toMap.transform(jsonishStringResult);
  print(mapResult.value);
  // {foo: bar}
```
