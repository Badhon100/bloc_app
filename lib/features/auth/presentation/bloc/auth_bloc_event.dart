part of 'auth_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

final class AuthSignUp extends AuthBlocEvent {
  final String email;
  final String password;
  final String name;

  AuthSignUp({required this.email, required this.password, required this.name});
}
