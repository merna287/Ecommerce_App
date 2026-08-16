import 'package:ecommerce_app/core/validators/validetor_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    test('required validator rejects empty values', () {
      expect(ValidatorApp.validateName(''), 'This field is required');
      expect(ValidatorApp.validateName(null), 'This field is required');
    });

    test('email validator accepts valid emails', () {
      expect(ValidatorApp.validateEmail('user@example.com'), null);
    });

    test('password validator enforces minimum length', () {
      expect(ValidatorApp.validatePassword('123'), 'Password must be at least 6 characters');
      expect(ValidatorApp.validatePassword('123456'), null);
    });
  });
}
