sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class SignInLoading extends AuthState {}

final class SignInSuccess extends AuthState {}

final class SignInFailure extends AuthState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}

final class OTPLoading extends AuthState {}

final class OTPSuccess extends AuthState {}

final class OTPFailure extends AuthState {
  final String errMessage;

  OTPFailure({required this.errMessage});
}
