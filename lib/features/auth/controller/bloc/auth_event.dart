part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginUser extends AuthEvent {
  final LoginUserData userData;
  const LoginUser({required this.userData});
}

class SignUpUser extends AuthEvent {
  final SignUpUserData userData;
  const SignUpUser({required this.userData});
}

class LogoutEvent extends AuthEvent {}

class ResetUserPassword extends AuthEvent {
  final String userEmail;

  const ResetUserPassword(this.userEmail);
}

class GetCurrentUserData extends AuthEvent {
  final UserDataModel userData;

  const GetCurrentUserData({required this.userData});
}

class SetUserName extends AuthEvent {
  final String userName;

  const SetUserName({required this.userName});
}

class CreateUser extends AuthEvent {
  final String userName;
  const CreateUser({required this.userName});
}
