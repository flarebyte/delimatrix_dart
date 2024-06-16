# delimatrix\_dart

![Experimental](https://img.shields.io/badge/status-experimental-blue)

> Delimatrix transforms strings to objects and back with a touch of magic

This versatile tool excels when handling results, typically in JSON format,
containing content that can be represented as multiple types of objects.
Depending on the context, the content might be a string, an array of strings,
or a more complex object

![Hero image for delimatrix\_dart](doc/delimatrix_dart.jpeg)

Highlights:

-   Uses transformers to convert between different types of objects.
-   Unopinionated JSON serialization support.
-   Provides a chainable API for transforming between different formats.
-   Validates input before transformation.

A few examples:

Transform a Map of string to a Shavian style JSON:

```dart
JsonTransformers.fromMap.chain(ToDxJsonTransformer(JsonEscapeConfigs.shavian)).transform(input);
```

Transform Shavian style JSON to a Map of string:

```dart
FromDxJsonTransformer(JsonEscapeConfigs.shavian).chain(JsonTransformers.toMap).transform(jsonishStringResult);
```

## Documentation and links

-   [Code Maintenance :wrench:](MAINTENANCE.md)
-   [Code Of Conduct](CODE_OF_CONDUCT.md)
-   [Contributing :busts\_in\_silhouette: :construction:](CONTRIBUTING.md)
-   [Architectural Decision Records :memo:](DECISIONS.md)
-   [Contributors
    :busts\_in\_silhouette:](https://github.com/flarebyte/delimatrix_dart/graphs/contributors)
-   [Dependencies](https://github.com/flarebyte/delimatrix_dart/network/dependencies)
-   [Glossary
    :book:](https://github.com/flarebyte/overview/blob/main/GLOSSARY.md)
-   [Software engineering principles
    :gem:](https://github.com/flarebyte/overview/blob/main/PRINCIPLES.md)
-   [Overview of Flarebyte.com ecosystem
    :factory:](https://github.com/flarebyte/overview)
-   [Dart dependencies](DEPENDENCIES.md)
-   [Usage](USAGE.md)
-   [Example](example/example.dart)

## Related

-   [JSON and serialization in
    Flutter](https://docs.flutter.dev/data-and-backend/serialization/json)
