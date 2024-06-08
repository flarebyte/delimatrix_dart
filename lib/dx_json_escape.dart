/// Immutable configuration class for JSON escape characters.
class JsonEscapeConfig {
  /// Character for escaping double quotes (`"`).
  final String doubleQuote;

  /// Character for escaping backslashes (`\`).
  final String backslash;

  /// Character for escaping line feeds (`\n`).
  final String lineFeed;

  /// Character for escaping carriage returns (`\r`).
  final String carriageReturn;

  /// Character for escaping horizontal tabs (`\t`).
  final String horizontalTab;

  /// Character for escaping backspaces (`\b`).
  final String backspace;

  /// Character for escaping form feeds (`\f`).
  final String formFeed;

  /// Character for escaping solidus (`/`).
  final String solidus;

  const JsonEscapeConfig._({
    required this.doubleQuote,
    required this.backslash,
    required this.lineFeed,
    required this.carriageReturn,
    required this.horizontalTab,
    required this.backspace,
    required this.formFeed,
    required this.solidus,
  });

  /// Returns a builder for creating a [JsonEscapeConfig] instance.
  static JsonEscapeConfigBuilder builder() => JsonEscapeConfigBuilder();
}

/// Builder class for constructing an instance of [JsonEscapeConfig].
class JsonEscapeConfigBuilder {
  String? _doubleQuote;
  String? _backslash;
  String? _lineFeed;
  String? _carriageReturn;
  String? _horizontalTab;
  String? _backspace;
  String? _formFeed;
  String? _solidus;

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

  /// Sets the character for escaping line feeds (`\n`).
  JsonEscapeConfigBuilder setLineFeed(String char) {
    _lineFeed = char;
    return this;
  }

  /// Sets the character for escaping carriage returns (`\r`).
  JsonEscapeConfigBuilder setCarriageReturn(String char) {
    _carriageReturn = char;
    return this;
  }

  /// Sets the character for escaping horizontal tabs (`\t`).
  JsonEscapeConfigBuilder setHorizontalTab(String char) {
    _horizontalTab = char;
    return this;
  }

  /// Sets the character for escaping backspaces (`\b`).
  JsonEscapeConfigBuilder setBackspace(String char) {
    _backspace = char;
    return this;
  }

  /// Sets the character for escaping form feeds (`\f`).
  JsonEscapeConfigBuilder setFormFeed(String char) {
    _formFeed = char;
    return this;
  }

  /// Sets the character for escaping solidus (`/`).
  JsonEscapeConfigBuilder setSolidus(String char) {
    _solidus = char;
    return this;
  }

  /// Builds and returns an instance of [JsonEscapeConfig] with the set or default values.
  JsonEscapeConfig build() {
    return JsonEscapeConfig._(
      doubleQuote: _doubleQuote ?? '\"',
      backslash: _backslash ?? '\\',
      lineFeed: _lineFeed ?? '\n',
      carriageReturn: _carriageReturn ?? '\r',
      horizontalTab: _horizontalTab ?? '\t',
      backspace: _backspace ?? '\b',
      formFeed: _formFeed ?? '\f',
      solidus: _solidus ?? '/',
    );
  }
}

/// A class that transforms a JSON string by escaping specific characters
/// based on the provided [JsonEscapeConfig].
class ToDxJsonTransformer {
  final JsonEscapeConfig config;

  /// Creates an instance of [ToDxJsonTransformer] with the given [config].
  ToDxJsonTransformer(this.config);

  /// Transforms the input [input] string by escaping characters
  /// according to the [config].
  String transformString(String input) {
    return input
        .replaceAll('"', config.doubleQuote)
        .replaceAll('\\', config.backslash)
        .replaceAll('\n', config.lineFeed)
        .replaceAll('\r', config.carriageReturn)
        .replaceAll('\t', config.horizontalTab)
        .replaceAll('\b', config.backspace)
        .replaceAll('\f', config.formFeed)
        .replaceAll('/', config.solidus);
  }
}

/// A class that transforms a JSON string by unescaping specific characters
/// based on the provided [JsonEscapeConfig].
class FromDxJsonTransformer {
  final JsonEscapeConfig config;

  /// Creates an instance of [FromDxJsonTransformer] with the given [config].
  FromDxJsonTransformer(this.config);

  /// Transforms the input [input] string by unescaping characters
  /// according to the [config].
  String transformString(String input) {
    return input
        .replaceAll(config.doubleQuote, '"')
        .replaceAll(config.backslash, '\\')
        .replaceAll(config.lineFeed, '\n')
        .replaceAll(config.carriageReturn, '\r')
        .replaceAll(config.horizontalTab, '\t')
        .replaceAll(config.backspace, '\b')
        .replaceAll(config.formFeed, '\f')
        .replaceAll(config.solidus, '/');
  }
}

