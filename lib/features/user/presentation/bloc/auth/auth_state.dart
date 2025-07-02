part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  final bool isDialogState;

  const AuthState({this.isDialogState = false});

  @override
  List<Object> get props => [];
}

sealed class AuthDialogState extends AuthState {
  const AuthDialogState({super.isDialogState = true});
}

final class AuthLoading extends AuthDialogState {}

final class AuthFailure extends AuthDialogState {
  final AppError error;

  const AuthFailure({required this.error});
}

sealed class AuthContentState extends AuthState {
  const AuthContentState({super.isDialogState = false});
}

final class AuthInitial extends AuthContentState {}

final class Authenticated extends AuthContentState {}

final class Unauthenticated extends AuthContentState {}
