import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/core/errors/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryhelper/features/user/domain/usecase/auth_usecase.dart';
import 'package:groceryhelper/core/services/talker_service.dart';
import 'dart:async';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  StreamSubscription<User?>? _authStateSubscription;

  AuthBloc({required this.authUsecase}) : super(AuthInitial()) {
    on<AuthInitEvent>(_onInit);
    on<AuthByGoogle>(_onAuthByGoogle);
    on<Unauthorize>(_onUnauthorize);
  }

  Future<void> _onInit(AuthInitEvent event, Emitter<AuthState> emit) async {
    await emit.onEach<User?>(
      authUsecase.authStateChanges,
      onData: (user) {
        if (user == null) {
          emit(Unauthenticated());
        } else {
          emit(Authenticated());
        }
      },
    );
  }

  Future<void> _onAuthByGoogle(AuthByGoogle event, Emitter<AuthState> emit) async {
    final credentials = await authUsecase.signInWithGoogle();
    credentials.fold(
      (failure) {
        TalkerService.error('Authentication failed: $failure');
        emit(AuthFailure(error: failure));
      },
      (creds) {
        TalkerService.log('User authenticated: ${creds.user?.email}');
        // emit(Authenticated()); // authStateChanges сам обновит
      },
    );
  }

  Future<void> _onUnauthorize(Unauthorize event, Emitter<AuthState> emit) async {
    await authUsecase.signOut();
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
