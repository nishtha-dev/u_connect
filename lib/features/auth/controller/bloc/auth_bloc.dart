import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/constants/auth_status.dart';
import '../../models/user_data_model.dart';
import '../repository/auth_repository.dart';

part 'auth_bloc.g.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends HydratedBloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;
  AuthBloc({required this.authRepo}) : super(const AuthState()) {
    on<LoginUser>(_handleLoginUser);
    on<SignUpUser>(_handleSignUpUser);
    on<LogoutEvent>(_logoutUser);
    on<ResetUserPassword>(_resetUserPassword);
    on<SetUserName>(_setUserName);
    on<CreateUser>(_createUser);
  }
  FutureOr<void> _handleLoginUser(
      LoginUser event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      AuthStatus status = await authRepo.loginUser(userData: event.userData);
      emit(state.copyWith(authStatus: status));
    } on Exception {
      emit(state.copyWith(authStatus: AuthStatus.error));
    }
  }

  FutureOr<void> _handleSignUpUser(
      SignUpUser event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      AuthStatus status = await authRepo.signUpUser(userData: event.userData);
      emit(state.copyWith(authStatus: status));
      add(CreateUser(userName: state.userName));
    } on Exception {
      emit(state.copyWith(authStatus: AuthStatus.error));
    }
  }

  FutureOr<void> _resetUserPassword(
      ResetUserPassword event, Emitter<AuthState> emit) async {
    emit(state.copyWith(authStatus: AuthStatus.loading));
    try {
      AuthStatus status =
          await authRepo.forgotPassword(userEmail: event.userEmail);
      emit(state.copyWith(authStatus: status));
    } on Exception {
      emit(state.copyWith(authStatus: AuthStatus.error));
    }
  }

  FutureOr<void> _logoutUser(LogoutEvent event, Emitter<AuthState> emit) async {
    await authRepo.signOut();
    emit(state.copyWith(authStatus: AuthStatus.initial));
  }

  FutureOr<void> _setUserName(
      SetUserName event, Emitter<AuthState> emit) async {
    emit(state.copyWith(userName: event.userName));
  }

  FutureOr<void> _createUser(CreateUser event, Emitter<AuthState> emit) async {
    // emit(state.copyWith(isUserCreatedSuccessFully: const Loading<bool>()));
    try {
      await authRepo.createUserAccount(userName: event.userName);
      // emit(
      // state.copyWith(isUserCreatedSuccessFully: const Success(data: true)));
    } on Exception {
      // emit(state.copyWith(isUserCreatedSuccessFully: const Failed('false')));
    }
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  @override
  Map<String, dynamic> toJson(AuthState state) => state.toJson();
}
