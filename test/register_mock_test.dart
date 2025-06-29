import 'package:flutter_test/flutter_test.dart';
import 'package:groceryhelper/features/register/data/repositories/register_repository_mock.dart';
import 'package:groceryhelper/features/register/domain/entities/register_request.dart';

void main() {
  group('RegisterRepositoryMock Tests', () {
    late RegisterRepositoryMock mockRepository;

    setUp(() {
      mockRepository = RegisterRepositoryMock();
    });

    test('should register new user successfully', () async {
      final request = RegisterRequest(username: 'testuser', email: 'newuser@example.com', password: 'Password123');

      final result = await mockRepository.registerWithEmailAndPassword(request);

      expect(result.isRight(), isTrue);
      result.fold((error) => fail('Should not return error'), (userCredential) {
        expect(userCredential.email, equals('newuser@example.com'));
        expect(userCredential.displayName, equals('testuser'));
        expect(userCredential.uid, contains('mock_uid_'));
      });
    });

    test('should fail registration with existing email', () async {
      final request = RegisterRequest(
        username: 'testuser',
        email: 'test@example.com', // Этот email уже занят
        password: 'Password123',
      );

      final result = await mockRepository.registerWithEmailAndPassword(request);

      expect(result.isLeft(), isTrue);
      result.fold((error) {
        expect(error.toString(), contains('Пользователь с такой почтой уже существует'));
      }, (userCredential) => fail('Should not return success'));
    });

    test('should check if email is already in use', () async {
      // Проверяем занятый email
      final result1 = await mockRepository.isEmailAlreadyInUse('test@example.com');
      expect(result1.isRight(), isTrue);
      result1.fold((error) => fail('Should not return error'), (isInUse) => expect(isInUse, isTrue));

      // Проверяем свободный email
      final result2 = await mockRepository.isEmailAlreadyInUse('new@example.com');
      expect(result2.isRight(), isTrue);
      result2.fold((error) => fail('Should not return error'), (isInUse) => expect(isInUse, isFalse));
    });

    test('should add email to used list after registration', () async {
      final email = 'newuser@example.com';

      // Проверяем, что email свободен
      final checkResult = await mockRepository.isEmailAlreadyInUse(email);
      checkResult.fold((error) => fail('Should not return error'), (isInUse) => expect(isInUse, isFalse));

      // Регистрируем пользователя
      final request = RegisterRequest(username: 'testuser', email: email, password: 'Password123');

      final registerResult = await mockRepository.registerWithEmailAndPassword(request);
      expect(registerResult.isRight(), isTrue);

      // Проверяем, что email теперь занят
      final checkResult2 = await mockRepository.isEmailAlreadyInUse(email);
      checkResult2.fold((error) => fail('Should not return error'), (isInUse) => expect(isInUse, isTrue));
    });

    test('should manage used emails list', () {
      // Проверяем начальные занятые email
      expect(mockRepository.usedEmails, contains('test@example.com'));
      expect(mockRepository.usedEmails, contains('admin@test.com'));
      expect(mockRepository.usedEmails, contains('user@demo.com'));

      // Добавляем новый email
      mockRepository.addUsedEmail('new@example.com');
      expect(mockRepository.usedEmails, contains('new@example.com'));

      // Очищаем список
      mockRepository.clearUsedEmails();
      expect(mockRepository.usedEmails, isEmpty);
    });

    test('should handle case insensitive email checking', () async {
      // Добавляем email в нижнем регистре
      mockRepository.addUsedEmail('test@example.com');

      // Проверяем с разными регистрами
      final result1 = await mockRepository.isEmailAlreadyInUse('TEST@EXAMPLE.COM');
      result1.fold((error) => fail('Should not return error'), (isInUse) => expect(isInUse, isTrue));

      final result2 = await mockRepository.isEmailAlreadyInUse('Test@Example.com');
      result2.fold((error) => fail('Should not return error'), (isInUse) => expect(isInUse, isTrue));
    });
  });
}
