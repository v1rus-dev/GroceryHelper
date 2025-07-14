part of '../../register.dart';

// Простой класс для имитации UserCredential
class MockUserCredential {
  final String uid;
  final String email;
  final String displayName;

  MockUserCredential({required this.uid, required this.email, required this.displayName});
}

class RegisterRepositoryMock implements RegisterRepository {
  // Список "занятых" email для тестирования
  final Set<String> _usedEmails = {'test@example.com', 'admin@test.com', 'user@demo.com'};

  // Имитация задержки сети
  final Duration _networkDelay = const Duration(milliseconds: 1500);

  @override
  Future<Either<AppError, dynamic>> registerWithEmailAndPassword(RegisterRequest request) async {
    try {
      TalkerService.log('Mock: Creating user with email: ${request.email}');

      // Имитируем задержку сети
      await Future.delayed(_networkDelay);

      // Проверяем, не занят ли email
      if (_usedEmails.contains(request.email.toLowerCase())) {
        TalkerService.warning('Mock: Email already in use: ${request.email}');
        return left(AppError(message: 'Пользователь с такой почтой уже существует', type: AppErrorType.dialog));
      }

      // Имитируем успешную регистрацию
      TalkerService.log('Mock: Successfully registered user: ${request.email}');

      // Добавляем email в список использованных
      _usedEmails.add(request.email.toLowerCase());

      // Возвращаем мок UserCredential
      return right(
        MockUserCredential(
          uid: 'mock_uid_${DateTime.now().millisecondsSinceEpoch}',
          email: request.email,
          displayName: request.username,
        ),
      );
    } catch (e) {
      TalkerService.error('Mock: Unexpected error during registration', e);
      return left(AppError(message: 'Неожиданная ошибка при регистрации', type: AppErrorType.dialog, cause: e));
    }
  }

  @override
  Future<Either<AppError, bool>> isEmailAlreadyInUse(String email) async {
    try {
      TalkerService.log('Mock: Checking if email is already in use: $email');

      // Имитируем задержку сети
      await Future.delayed(const Duration(milliseconds: 500));

      final isInUse = _usedEmails.contains(email.toLowerCase());

      TalkerService.log('Mock: Email $email is ${isInUse ? 'already in use' : 'available'}');
      return right(isInUse);
    } catch (e) {
      TalkerService.error('Mock: Unexpected error while checking email', e);
      return left(AppError(message: 'Ошибка при проверке почты', type: AppErrorType.dialog, cause: e));
    }
  }

  // Метод для добавления тестовых email
  void addUsedEmail(String email) {
    _usedEmails.add(email.toLowerCase());
  }

  // Метод для очистки тестовых данных
  void clearUsedEmails() {
    _usedEmails.clear();
  }

  // Метод для получения списка использованных email
  Set<String> get usedEmails => Set.from(_usedEmails);
}
