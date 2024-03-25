part of 'auth_bloc.dart';

@JsonSerializable(explicitToJson: true)
class AuthState extends Equatable {
  final AuthStatus authStatus;
  final String userName;
  // final ApiStatus<bool> isUserCreatedSuccessFully;

  const AuthState({
    this.authStatus = AuthStatus.initial,
    this.userName = '',
    // this.isUserCreatedSuccessFully = const Initial<bool>(),
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    String? userName,
    // ApiStatus<bool>? isUserCreatedSuccessFully
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
