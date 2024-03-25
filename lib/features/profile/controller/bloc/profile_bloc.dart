import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:u_connect/core/utils/utils.dart';
import 'package:u_connect/features/auth/models/user_data_model.dart';
import 'package:u_connect/features/profile/controller/repository/profile_repository.dart';
import 'package:u_connect/features/profile/view/widgets/edit_profile_bottom_sheet.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository}) : super(const ProfileState()) {
    on<GetUserData>(_getUserData);
    on<CaptureImage>(_captureImage);
    on<SelectImage>(_selectImage);
    on<UpdateUserData>(_updateUserData);
    on<UploadImage>(_uploadImage);
  }
  FutureOr<void> _getUserData(
      GetUserData event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(userData: const Loading<UserDataModel>()));
    try {
      final response = await profileRepository.getUserProfileData();

      emit(state.copyWith(userData: Success(data: response)));
    } catch (e) {
      emit(state.copyWith(userData: const Failed('error')));
    }
  }

  FutureOr<void> _updateUserData(
      UpdateUserData event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isUserUpdateSuccessFully: const Loading<bool>()));
    try {
      await profileRepository.updateUserProfileData(data: event.userData);

      add(const GetUserData());
      emit(state.copyWith(isUserUpdateSuccessFully: const Success(data: true)));
    } on Exception {
      emit(state.copyWith(isUserUpdateSuccessFully: const Failed('false')));
    }
  }

  Future<void> _selectImage(
    SelectImage event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      Haptic.vibrate();
      XFile? capturedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      add(UploadImage(capturedImage: capturedImage));
    } catch (e) {
      final PermissionStatus galleryAccessStatus =
          await Permission.photos.status;
      emit(
        state.copyWith(
          galleryAccessStatus: galleryAccessStatus,
        ),
      );
    }
  }

  Future<void> _captureImage(
    CaptureImage event,
    Emitter<ProfileState> emit,
  ) async {
    Haptic.vibrate();
    try {
      XFile? capturedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      add(UploadImage(capturedImage: capturedImage));
    } catch (e) {
      final PermissionStatus cameraPermissionStatus =
          await Permission.camera.status;

      emit(
        state.copyWith(
          cameraPermissionFailureCount: state.cameraPermissionFailureCount + 1,
          cameraPermissionStatus: cameraPermissionStatus,
        ),
      );
    }
  }

  FutureOr<void> _uploadImage(
    UploadImage event,
    Emitter<ProfileState> emit,
  ) async {
    if (event.capturedImage == null) return;
    emit(state.copyWith(profileImageDownloadUrl: const Loading<String>()));
    try {
      Uint8List fileData = await event.capturedImage!.readAsBytes();

      final downloadUrl =
          await profileRepository.uploadImageToCloud(imageFile: fileData);

      state.userData.whenOrNull(
        success: (data) {
          final UserDataModel userData = data;
          emit(state.copyWith(
              profileImageDownloadUrl: Success(data: downloadUrl),
              userData: Success(data: userData.copyWith(avatar: downloadUrl))));
        },
      );
    } on Exception {
      emit(state.copyWith(profileImageDownloadUrl: const Failed('false')));
    }
  }
}
