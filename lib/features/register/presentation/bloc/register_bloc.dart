import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'package:groceryhelper/features/register/domain/entities/register_request.dart';
import 'package:groceryhelper/features/register/domain/usecases/register_usecase.dart';
import 'package:groceryhelper/features/register/domain/repositories/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  late final RegisterUsecase _registerUsecase;

  RegisterBloc({required RegisterRepository registerRepository}) : super(RegisterInitial()) {
    _registerUsecase = RegisterUsecase(registerRepository: registerRepository);

    on<RegisterUserEvent>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(RegisterUserEvent event, Emitter<RegisterState> emit) async {
    try {
      TalkerService.log('RegisterBloc: Starting registration process');
      emit(RegisterLoading());

      final registerRequest = RegisterRequest(username: event.username, email: event.email, password: event.password);

      final result = await _registerUsecase.execute(registerRequest);

      await Future.delayed(Duration(seconds: 2));

      result.fold(
        (exception) {
          TalkerService.error('RegisterBloc: Registration failed', exception);
          emit(RegisterError(error: exception));
        },
        (userCredential) {
          TalkerService.log('RegisterBloc: Registration successful');
          emit(RegisterSuccess());
        },
      );
    } catch (e) {
      TalkerService.error('RegisterBloc: Unexpected error', e);
      emit(
        RegisterError(
          error: AppError(message: e.toString(), type: AppErrorType.dialog),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    TalkerService.log('RegisterBloc: Closing');
    return super.close();
  }
}
