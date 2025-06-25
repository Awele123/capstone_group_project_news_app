part of 'auth_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthLoadingState extends AuthenticationState {}

final class ProfileUpdated extends AuthenticationState {}

final class NoPasswordState extends AuthenticationState {}

final class AuthenticationInitialState extends AuthenticationState {}

final class LoginState extends AuthenticationState {}

final class AuthLoadedState extends AuthenticationState {}

final class RegisteredState extends AuthenticationState {}

final class RegisteredFailedState extends AuthenticationState {}

final class ProfileFetched extends AuthenticationState {}

final class LoggedOutState extends AuthenticationState {}

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
