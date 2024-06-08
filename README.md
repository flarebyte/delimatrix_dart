# delimatrix_dart

> Delimatrix Dart transforms strings to objects and back with a touch of magic.

This versatile tool excels when handling results, typically in JSON format, containing content that can be represented as multiple types of objects. Depending on the context, the content might be a string, an array of strings, or a more complex object.

![Delimatrix](doc/delimatrix.jpeg)

Highlights:

- Uses transformers to convert between different types of objects.
- Unopinionated JSON serialization support.
- Provides a chainable API for transforming between different formats.
- Validates input before transformation.

## Example

See `example/example.dart`

```dart
final fromMap = JsonTransformers.fromMap
      .chain(ToDxJsonTransformer(JsonEscapeConfigs.shavian));

  final toMap = FromDxJsonTransformer(JsonEscapeConfigs.shavian)
      .chain(JsonTransformers.toMap);

  const DxResult<Map<String, String>> input = DxSuccess({'foo': 'bar'});

  // Convert a Map<String, String> to Delimatrix style JSON
  final jsonishStringResult = fromMap.transform(input);
  print(jsonishStringResult.value);
  // {𐑖foo𐑖:𐑖bar𐑖}

  // Convert Delimatrix style JSON back to  Map<String, String>
  final mapResult = toMap.transform(jsonishStringResult);
  print(mapResult.value);
  // {foo: bar}
```

## Motivation

Traditionally, dealing with such cases involves parsing the JSON result in a single pass, expanding the content field into an object if necessary, and allowing the code to manage any type changes. Delimatrix, however, employs a different approach by assuming two parsing phases.

In the first phase, the initial JSON is converted into an object while leaving the content field as a string. In the second phase, the content field is transformed into the appropriate object representation if needed. This method, although somewhat unconventional, introduces a higher level of flexibility but can pose a security risk if not implemented correctly.

Despite these challenges, the benefits are significant. This approach allows for a variety of models for the content field, which can evolve over time. Moreover, the second parsing phase can handle diverse formats such as JSON, YAML, CSV, Markdown, etc.

Additionally, the Delimatrix library addresses a common issue encountered when encoding a field in JSON and then encoding the result in JSON again. This process often involves numerous escaping codes, which can be noisy for a human reader. Delimatrix resolves this by converting characters that need to be escaped into characters that do not, simplifying the encoding process.

In summary, Delimatrix not only provides a powerful and flexible solution for transforming strings into objects and vice versa but also enhances the ease of handling complex content representations in various formats.
