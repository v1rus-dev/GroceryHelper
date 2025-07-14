part of '../../register.dart';

class RegisterRequest extends Equatable {
  final String username;
  final String email;
  final String password;

  const RegisterRequest({required this.username, required this.email, required this.password});

  @override
  List<Object> get props => [username, email, password];

  bool get isValid {
    return username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        username.length >= 3 &&
        username.length <= 32 &&
        password.length >= 8 &&
        password.length <= 50 &&
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
}
