part of 'auth_bloc.dart';

@JsonSerializable(explicitToJson: true)
class AuthState extends Equatable {
  final AuthStatus authStatus;
  final String userName;

  const AuthState({
    this.authStatus = AuthStatus.initial,
    this.userName = '',
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    String? userName,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      userName: userName ?? this.userName,
    );
  }

  bool get isAuthenticated {
    return authStatus.isLoginSuccess || authStatus.isSignUpSuccess;
  }

  @override
  List<Object?> get props => [authStatus, userName];

  static AuthState fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
  Map<String, dynamic> toJson() => _$AuthStateToJson(this);
}
