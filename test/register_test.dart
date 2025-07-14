import 'package:flutter_test/flutter_test.dart';
import 'package:groceryhelper/features/register/register.dart';

void main() {
  group('RegisterRequest Tests', () {
    test('should be valid with correct data', () {
      final request = RegisterRequest(username: 'testuser', email: 'test@example.com', password: 'Password123');

      expect(request.isValid, isTrue);
    });

    test('should be invalid with short username', () {
      final request = RegisterRequest(username: 'ab', email: 'test@example.com', password: 'Password123');

      expect(request.isValid, isFalse);
    });

    test('should be invalid with long username', () {
      final request = RegisterRequest(
        username: 'a' * 33, // 33 characters
        email: 'test@example.com',
        password: 'Password123',
      );

      expect(request.isValid, isFalse);
    });

    test('should be invalid with invalid email', () {
      final request = RegisterRequest(username: 'testuser', email: 'invalid-email', password: 'Password123');

      expect(request.isValid, isFalse);
    });

    test('should be invalid with short password', () {
      final request = RegisterRequest(username: 'testuser', email: 'test@example.com', password: 'Pass1');

      expect(request.isValid, isFalse);
    });

    test('should be invalid with long password', () {
      final request = RegisterRequest(
        username: 'testuser',
        email: 'test@example.com',
        password: 'a' * 51, // 51 characters
      );

      expect(request.isValid, isFalse);
    });

    test('should be invalid with empty fields', () {
      final request = RegisterRequest(username: '', email: '', password: '');

      expect(request.isValid, isFalse);
    });

    test('should be valid with valid email formats', () {
      final validEmails = ['test@example.com', 'user.name@domain.co.uk', 'user+tag@example.org', '123@example.com'];

      for (final email in validEmails) {
        final request = RegisterRequest(username: 'testuser', email: email, password: 'Password123');

        expect(request.isValid, isTrue, reason: 'Email $email should be valid');
      }
    });

    test('should be invalid with invalid email formats', () {
      final invalidEmails = ['test@', '@example.com', 'test.example.com', 'test@.com', 'test@example.'];

      for (final email in invalidEmails) {
        final request = RegisterRequest(username: 'testuser', email: email, password: 'Password123');

        expect(request.isValid, isFalse, reason: 'Email $email should be invalid');
      }
    });
  });
}
