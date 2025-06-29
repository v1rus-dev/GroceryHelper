import 'package:dartz/dartz.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'package:groceryhelper/features/register/domain/entities/register_request.dart';
import 'package:groceryhelper/features/register/domain/repositories/register_repository.dart';

class RegisterUsecase {
  final RegisterRepository _registerRepository;

  RegisterUsecase({required RegisterRepository registerRepository}) : _registerRepository = registerRepository;

  Future<Either<Exception, dynamic>> execute(RegisterRequest request) async {
    try {
      TalkerService.log('Starting registration process for email: ${request.email}');

      if (!request.isValid) {
        TalkerService.warning('Invalid registration request data');
        return left(Exception('Неверные данные для регистрации'));
      }

      // Проверяем, не занят ли email
      final emailCheckResult = await _registerRepository.isEmailAlreadyInUse(request.email);

      return emailCheckResult.fold((exception) => left(exception), (isInUse) {
        if (isInUse) {
          TalkerService.warning('Email already in use: ${request.email}');
          return left(Exception('Пользователь с такой почтой уже существует'));
        }

        // Выполняем регистрацию
        return _registerRepository.registerWithEmailAndPassword(request);
      });
    } catch (e) {
      TalkerService.error('Error in register usecase', e);
      return left(Exception(e.toString()));
    }
  }
}
