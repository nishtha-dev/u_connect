import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  initial,
  loading,
  resetPasswordSuccess,
  loginSuccess,
  signUpSuccess,
  invalidEmail,
  userDisabled,
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  invalidCredential,
  operationNotAllowed,
  weakPassword,
  error,
}

AuthStatus getAuthStatus(FirebaseAuthException exception) {
  switch (exception.code.toLowerCase()) {
    case 'invalid-email':
      return AuthStatus.invalidEmail;
    case 'user-disabled':
      return AuthStatus.userDisabled;
    case 'user-not-found':
      return AuthStatus.userNotFound;
    case 'wrong-password':
      return AuthStatus.wrongPassword;
    case 'email-already-in-use':
    case 'account-exists-with-different-credential':
      return AuthStatus.emailAlreadyInUse;
    case 'invalid-credential':
    case 'invalid-login-credential':
      return AuthStatus.invalidCredential;
    case 'operation-not-allowed':
      return AuthStatus.operationNotAllowed;
    case 'weak-password':
      return AuthStatus.weakPassword;
    default:
      return AuthStatus.error;
  }
}

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;
  bool get isLoginSuccess => this == AuthStatus.loginSuccess;
  bool get isLoading => this == AuthStatus.loading;
  bool get isSignUpSuccess => this == AuthStatus.signUpSuccess;
  bool get isResetPasswordSuccess => this == AuthStatus.resetPasswordSuccess;
  bool get isFailure => (this != AuthStatus.loginSuccess &&
      this != AuthStatus.signUpSuccess &&
      this != AuthStatus.initial &&
      this != AuthStatus.loading &&
      this != AuthStatus.resetPasswordSuccess);
  String get getErrorString {
    switch (this) {
      case AuthStatus.emailAlreadyInUse:
        return "Email already in use";
      case AuthStatus.invalidEmail:
        return "Invalid email";
      case AuthStatus.userNotFound:
        return "User not found";
      case AuthStatus.wrongPassword:
        return "Wrong password";
      case AuthStatus.invalidCredential:
        return "Invalid credentials";
      case AuthStatus.weakPassword:
        return "Password is too weak";
      case AuthStatus.userDisabled:
        return "User is disabled";
      case AuthStatus.operationNotAllowed:
        return "Operation not allowed";
      default:
        return "Failed to connect";
    }
  }
}
