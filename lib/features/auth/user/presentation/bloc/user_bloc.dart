import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cookmatch/features/auth/user/domain/usecase/auth_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AuthUsecase authUsecase;

  StreamSubscription? _authStateSubscription;

  UserBloc({required this.authUsecase}) : super(UserInitial()) {
    on<UserInitEvent>(_onInit);
    on<AuthByGoogle>(_onAuthByGoogle);
  }

  _onInit(UserInitEvent event, Emitter<UserState> emit) async {
    await emit.onEach<User?>(
      authUsecase.authStateChanges,
      onData: (user) {
        print('User: $user');
        if (user == null) {
          emit(UserUnauthenticated());
        } else {
          emit(UserAuthenticated());
        }
      },
    );
  }

  _onAuthByGoogle(AuthByGoogle event, Emitter<UserState> emit) async {
    final credentials = await authUsecase.signInWithGoogle();
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
