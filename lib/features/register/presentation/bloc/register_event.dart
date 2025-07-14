part of '../../register.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class RegisterUserEvent extends RegisterEvent {
  final String username;
  final String email;
  final String password;

  const RegisterUserEvent({required this.username, required this.email, required this.password});
}
