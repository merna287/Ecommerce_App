import 'package:ecommerce_app/core/validators/validator_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ValidatorApp.validateName', () {
    test('rejects empty values', () {
      expect(ValidatorApp.validateName(''), 'Name cannot be empty');
      expect(ValidatorApp.validateName(null), 'Name cannot be empty');
    });

    test('accepts non-empty names', () {
      expect(ValidatorApp.validateName('John Doe'), null);
    });
  });

  group('ValidatorApp.validateEmail', () {
    test('rejects empty values', () {
      expect(ValidatorApp.validateEmail(''), 'Email cannot be empty');
      expect(ValidatorApp.validateEmail(null), 'Email cannot be empty');
    });

    test('rejects invalid emails', () {
      expect(ValidatorApp.validateEmail('not-an-email'), isNotNull);
      expect(ValidatorApp.validateEmail('user@'), isNotNull);
      expect(ValidatorApp.validateEmail('user@example'), isNotNull);
    });

    test('accepts valid emails', () {
      expect(ValidatorApp.validateEmail('user@example.com'), null);
    });
  });

  group('ValidatorApp.validatePassword', () {
    test('rejects empty values', () {
      expect(ValidatorApp.validatePassword(''), 'Password cannot be empty');
      expect(ValidatorApp.validatePassword(null), 'Password cannot be empty');
    });

    test('enforces minimum length, uppercase, and a number', () {
      expect(ValidatorApp.validatePassword('123'), isNotNull);
      expect(ValidatorApp.validatePassword('abcdefg'), isNotNull);
      expect(ValidatorApp.validatePassword('abcdefgh'), isNotNull);

      expect(ValidatorApp.validatePassword('Password1'), null);
    });
  });

  group('ValidatorApp.validateConfirmPassword', () {
    test('rejects empty values', () {
      expect(
        ValidatorApp.validateConfirmPassword('', 'password'),
        'Confirm password cannot be empty',
      );
      expect(
        ValidatorApp.validateConfirmPassword(null, 'password'),
        'Confirm password cannot be empty',
      );
    });

    test('rejects a mismatched password', () {
      expect(
        ValidatorApp.validateConfirmPassword('abc', 'xyz'),
        'Confirm password must match the password',
      );
    });

    test('accepts a matching password', () {
      expect(
        ValidatorApp.validateConfirmPassword('password', 'password'),
        null,
      );
    });
  });
}
