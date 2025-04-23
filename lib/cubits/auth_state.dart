part of 'auth_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthLoadingState extends AuthenticationState {}

final class ProfileUpdated extends AuthenticationState {}

final class NoPasswordState extends AuthenticationState {}

final class NoAccountState extends AuthenticationState {}

final class AuthenticationInitialState extends AuthenticationState {}

final class LoginState extends AuthenticationState {}

final class AuthLoadedState extends AuthenticationState {}

final class RegisteredState extends AuthenticationState {}

final class RegisteredFailedState extends AuthenticationState {}

final class EmailValid extends AuthenticationState {}

final class EmailNotValid extends AuthenticationState {}

final class ProfileFetched extends AuthenticationState {}

final class LoginInvalidState extends AuthenticationState {}

final class LoginValidState extends AuthenticationState {}

final class CreateAccount extends AuthenticationState {}

// final class InvalidOtpState extends AuthState {
//   final String msg;
//   const InvalidOtpState({required this.msg});
//   @override
//   List<Object> get props => [];
// }

final class AuthErrorState extends AuthenticationState {
  final String error;
  const AuthErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

final class ErrorState extends AuthenticationState {
  final String error;
  const ErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
