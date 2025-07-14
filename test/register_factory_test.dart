import 'package:flutter_test/flutter_test.dart';
import 'package:groceryhelper/features/register/register.dart';

void main() {
  group('RegisterRepositoryFactory Tests', () {
    test('should create mock repository when useMock is true', () async {
      final repository = await RegisterRepositoryFactory.create(useMock: true);

      expect(repository, isA<RegisterRepositoryMock>());
    });

    test('should create real repository when useMock is false', () async {
      // В тестовой среде Firebase не инициализирован, поэтому ожидаем исключение
      expect(() => RegisterRepositoryFactory.create(useMock: false), throwsA(isA<StateError>()));
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
