part of '../../register.dart';

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
