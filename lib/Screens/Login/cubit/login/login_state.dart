part of 'login_cubit.dart';

@immutable
sealed class LoginState {
  const LoginState();
}

final class LoginInitial extends LoginState {
  const LoginInitial();
}

final class LoginLoading extends LoginState {
  const LoginLoading();
}

final class LoginPass extends LoginState {
  const LoginPass();
}

final class LoginFailed extends LoginState {
  const LoginFailed();
}
