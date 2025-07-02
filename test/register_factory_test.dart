import 'package:flutter_test/flutter_test.dart';
import 'package:groceryhelper/features/register/data/repositories/register_repository_factory.dart';
import 'package:groceryhelper/features/register/data/repositories/register_repository_mock.dart';
import 'package:groceryhelper/features/register/data/repositories/register_repository_impl.dart';

void main() {
  group('RegisterRepositoryFactory Tests', () {
    test('should create mock repository when useMock is true', () async {
      final repository = await RegisterRepositoryFactory.create(useMock: true);

      expect(repository, isA<RegisterRepositoryMock>());
    });

    test('should create real repository when useMock is false', () async {
      // В тестовой среде Firebase не инициализирован, поэтому ожидаем исключение
      final repository = await RegisterRepositoryFactory.create(useMock: false);

      expect(repository, isA<RegisterRepositoryImpl>());
    });

    test('should create mock repository by default', () async {
      final repository = await RegisterRepositoryFactory.create();

      expect(repository, isA<RegisterRepositoryMock>());
    });

    test('should create different instances each time', () async {
      final repository1 = await RegisterRepositoryFactory.create(useMock: true);
      final repository2 = await RegisterRepositoryFactory.create(useMock: true);

      expect(repository1, isNot(same(repository2)));
    });
  });
}
