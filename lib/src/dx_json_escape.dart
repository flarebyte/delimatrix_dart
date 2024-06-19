import 'dx_result.dart';
import 'dx_transformer.dart';

/// Immutable configuration class for JSON escape characters.
class JsonEscapeConfig {
  /// Character for escaping double quotes (`"`).
  final String doubleQuote;

  /// Character for escaping backslashes (`\`).
  final String backslash;

  const JsonEscapeConfig._({
    required this.doubleQuote,
    required this.backslash,
  });

  /// Returns a builder for creating a [JsonEscapeConfig] instance.
  static JsonEscapeConfigBuilder builder() => JsonEscapeConfigBuilder();
}

/// Builder class for constructing an instance of [JsonEscapeConfig].
class JsonEscapeConfigBuilder {
  String? _doubleQuote;
  String? _backslash;

  /// Sets the character for escaping double quotes (`"`).
  JsonEscapeConfigBuilder setDoubleQuote(String char) {
    _doubleQuote = char;
    return this;
  }

  /// Sets the character for escaping backslashes (`\`).
  JsonEscapeConfigBuilder setBackslash(String char) {
    _backslash = char;
    return this;
  }

  /// Builds and returns an instance of [JsonEscapeConfig] with the set or default values.
  JsonEscapeConfig build() {
    return JsonEscapeConfig._(
      doubleQuote: _doubleQuote ?? '"',
      backslash: _backslash ?? '\\',
    );
  }
}

/// JSON Escape configuration using rarely used characters
class JsonEscapeConfigs {
  static final JsonEscapeConfig shavianConfig = JsonEscapeConfig.builder()
      .setDoubleQuote('𐑣') // Shavian letter "Ha Ha"
      .setBackslash('𐑯') // Shavian letter "Nun"
      .build();

  static final JsonEscapeConfig linearBConfig = JsonEscapeConfig.builder()
      .setDoubleQuote('𐀀') // Linear B Syllable B008 A
      .setBackslash('𐀁') // Linear B Syllable B038 E
      .build();

  /// The Shavian alphabet, designed by Kingsley Read and named after George Bernard Shaw, is a phonemic orthography intended to simplify English spelling.
  static JsonEscapeConfig get shavian => shavianConfig;

  /// An ancient script used for writing Mycenaean Greek
  static JsonEscapeConfig get linearB => linearBConfig;
}

/// A class that transforms a JSON string by escaping specific characters
/// based on the provided [JsonEscapeConfig].
class ToDxJsonTransformer extends DxTransformer<String, String> {
  final JsonEscapeConfig config;

  /// Creates an instance of [ToDxJsonTransformer] with the given [config].
  ToDxJsonTransformer(this.config);

  /// Private method Checks if any of the replacement characters in the [config] are present in the [input] string.
  bool _hasNotAnyTargetChar(String input) {
    return !(input.contains(config.doubleQuote) ||
        input.contains(config.backslash));
  }

  /// Private method to transform the input string by escaping characters.
  String _transformString(String input) {
    return input
        .replaceAll('"', config.doubleQuote)
        .replaceAll('\\', config.backslash);
  }

  @override
  DxResult<String> transform(DxResult<String> input) {
    return input
        .validate(_hasNotAnyTargetChar, 'delimatrix:199fdd19',
            'Special chars already in payload')
        .map(_transformString);
  }
}

/// A class that transforms a JSON string by unescaping specific characters
/// based on the provided [JsonEscapeConfig].
class FromDxJsonTransformer extends DxTransformer<String, String> {
  final JsonEscapeConfig config;

  /// Creates an instance of [FromDxJsonTransformer] with the given [config].
  FromDxJsonTransformer(this.config);

  /// Private method to transform the input string by unescaping characters.
  String _transformString(String input) {
    return input
        .replaceAll(config.doubleQuote, '"')
        .replaceAll(config.backslash, '\\');
  }

  @override
  DxResult<String> transform(DxResult<String> input) {
    return input.map(_transformString);
  }
}
