import 'package:delimatrix_dart/dx_json_escape.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('JsonEscapeConfigBuilder', () {
    test('should build JsonEscapeConfig with default values', () {
      final config = JsonEscapeConfig.builder().build();

      expect(config.doubleQuote, equals('\"'));
      expect(config.backslash, equals('\\'));
      expect(config.lineFeed, equals('\n'));
      expect(config.carriageReturn, equals('\r'));
      expect(config.horizontalTab, equals('\t'));
      expect(config.backspace, equals('\b'));
      expect(config.formFeed, equals('\f'));
      expect(config.solidus, equals('/'));
    });

    test('should set and build JsonEscapeConfig with custom values', () {
      final config = JsonEscapeConfig.builder()
        .setDoubleQuote('*')
        .setBackslash('#')
        .setLineFeed('@')
        .setCarriageReturn('%')
        .setHorizontalTab('&')
        .setBackspace('!')
        .setFormFeed('^')
        .setSolidus('~')
        .build();

      expect(config.doubleQuote, equals('*'));
      expect(config.backslash, equals('#'));
      expect(config.lineFeed, equals('@'));
      expect(config.carriageReturn, equals('%'));
      expect(config.horizontalTab, equals('&'));
      expect(config.backspace, equals('!'));
      expect(config.formFeed, equals('^'));
      expect(config.solidus, equals('~'));
    });

    test('should allow setting only some values and use defaults for others', () {
      final config = JsonEscapeConfig.builder()
        .setDoubleQuote('*')
        .setLineFeed('@')
        .build();

      expect(config.doubleQuote, equals('*'));
      expect(config.backslash, equals('\\'));
      expect(config.lineFeed, equals('@'));
      expect(config.carriageReturn, equals('\r'));
      expect(config.horizontalTab, equals('\t'));
      expect(config.backspace, equals('\b'));
      expect(config.formFeed, equals('\f'));
      expect(config.solidus, equals('/'));
    });
  });
}
