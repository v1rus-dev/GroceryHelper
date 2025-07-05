import 'package:dartz/dartz.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';
import 'package:groceryhelper/features/register/domain/entities/register_request.dart';
import 'package:groceryhelper/features/register/domain/repositories/register_repository.dart';

class RegisterUsecase {
  final RegisterRepository _registerRepository;

  RegisterUsecase({required RegisterRepository registerRepository}) : _registerRepository = registerRepository;

  Future<Either<AppError, dynamic>> execute(RegisterRequest request) async {
    try {
      TalkerService.log('Starting registration process for email: ${request.email}');

      if (!request.isValid) {
        TalkerService.warning('Invalid registration request data');
        return left(AppError(message: 'Неверные данные для регистрации', type: AppErrorType.dialog));
      }

      // Проверяем, не занят ли email
      final emailCheckResult = await _registerRepository.isEmailAlreadyInUse(request.email);

      return emailCheckResult.fold((exception) => left(exception), (isInUse) {
        if (isInUse) {
          TalkerService.warning('Email already in use: ${request.email}');
          return left(AppError(message: 'Пользователь с такой почтой уже существует', type: AppErrorType.dialog));
        }

        // Выполняем регистрацию
        return _registerRepository.registerWithEmailAndPassword(request);
      });
    } catch (e) {
      TalkerService.error('Error in register usecase', e);
      return left(AppError(message: e.toString(), type: AppErrorType.dialog));
    }
  }
}
