import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:groceryhelper/shared/errors/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groceryhelper/features/user/domain/usecase/auth_usecase.dart';
import 'package:groceryhelper/infrastructure/services/talker_service.dart';
import 'dart:async';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  StreamSubscription<User?>? _authStateSubscription;
  AuthContentState? _lastContentState;

  AuthBloc({required this.authUsecase}) : super(AuthInitial()) {
    on<AuthInitEvent>(_onInit);
    on<AuthByGoogle>(_onAuthByGoogle);
    on<AuthByApple>(_onAuthByApple);
    on<AuthByEmail>(_onAuthByEmail);
    on<Unauthorize>(_onUnauthorize);
    on<ResetToContentState>(_onResetToContentState);
  }

  void _emitContentState(AuthContentState state, Emitter<AuthState> emit) {
    _lastContentState = state;
    emit(state);
  }

  Future<void> _onInit(AuthInitEvent event, Emitter<AuthState> emit) async {
    await emit.onEach<User?>(
      authUsecase.user,
      onData: (user) {
        if (user == null) {
          _emitContentState(Unauthenticated(), emit);
        } else {
          _emitContentState(Authenticated(user: user), emit);
        }
      },
    );
  }

  Future<void> _onAuthByGoogle(AuthByGoogle event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final credentials = await authUsecase.signInWithGoogle();
    credentials.fold(
      (failure) {
        TalkerService.error('Authentication failed: $failure');
        emit(AuthFailure(error: failure));
      },
      (creds) {
        TalkerService.log('User authenticated: ${creds.user?.email}');
        emit(AuthSuccess());
      },
    );
  }

  Future<void> _onAuthByApple(AuthByApple event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final credentials = await authUsecase.signInWithApple();
    credentials.fold(
      (failure) {
        TalkerService.error('Authentication failed: $failure');
        emit(AuthFailure(error: failure));
      },
      (creds) {
        TalkerService.log('User authenticated: ${creds.user?.email}');
        emit(AuthSuccess());
      },
    );
  }

  Future<void> _onAuthByEmail(AuthByEmail event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final credentials = await authUsecase.signInWithEmailAndPassword(event.email, event.password);
    credentials.fold(
      (failure) {
        TalkerService.error('Authentication failed: $failure');
        emit(AuthFailure(error: failure));
      },
      (creds) {
        TalkerService.log('User authenticated: ${creds.user?.email}');
        emit(AuthSuccess());
      },
    );
  }

  Future<void> _onUnauthorize(Unauthorize event, Emitter<AuthState> emit) async {
    await authUsecase.signOut();
  }

  Future<void> _onResetToContentState(ResetToContentState event, Emitter<AuthState> emit) async {
    if (_lastContentState != null) {
      _emitContentState(_lastContentState!, emit);
    } else {
      _emitContentState(AuthInitial(), emit);
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
