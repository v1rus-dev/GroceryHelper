import 'package:flutter_test/flutter_test.dart';
import 'package:groceryhelper/features/register/data/repositories/register_repository_factory.dart';
import 'package:groceryhelper/features/register/data/repositories/register_repository_mock.dart';
import 'package:groceryhelper/features/register/data/repositories/register_repository_impl.dart';

void main() {
  group('RegisterRepositoryFactory Tests', () {
    test('should create mock repository when useMock is true', () {
      final repository = RegisterRepositoryFactory.create(useMock: true);

      expect(repository, isA<RegisterRepositoryMock>());
    });

    test('should create real repository when useMock is false', () {
      // В тестовой среде Firebase не инициализирован, поэтому ожидаем исключение
      expect(() => RegisterRepositoryFactory.create(useMock: false), throwsA(isA<Exception>()));
    });

    test('should create mock repository by default', () {
      final repository = RegisterRepositoryFactory.create();

      expect(repository, isA<RegisterRepositoryMock>());
    });

    test('should create different instances each time', () {
      final repository1 = RegisterRepositoryFactory.create(useMock: true);
      final repository2 = RegisterRepositoryFactory.create(useMock: true);

      expect(repository1, isNot(same(repository2)));
    });
  });
}
