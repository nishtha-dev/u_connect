// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) => AuthState(
      authStatus:
          $enumDecodeNullable(_$AuthStatusEnumMap, json['authStatus']) ??
              AuthStatus.initial,
      userName: json['userName'] as String? ?? '',
    );

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'authStatus': _$AuthStatusEnumMap[instance.authStatus]!,
      'userName': instance.userName,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.initial: 'initial',
  AuthStatus.loading: 'loading',
  AuthStatus.resetPasswordSuccess: 'resetPasswordSuccess',
  AuthStatus.loginSuccess: 'loginSuccess',
  AuthStatus.signUpSuccess: 'signUpSuccess',
  AuthStatus.invalidEmail: 'invalidEmail',
  AuthStatus.userDisabled: 'userDisabled',
  AuthStatus.userNotFound: 'userNotFound',
  AuthStatus.wrongPassword: 'wrongPassword',
  AuthStatus.emailAlreadyInUse: 'emailAlreadyInUse',
  AuthStatus.invalidCredential: 'invalidCredential',
  AuthStatus.operationNotAllowed: 'operationNotAllowed',
  AuthStatus.weakPassword: 'weakPassword',
  AuthStatus.error: 'error',
};
