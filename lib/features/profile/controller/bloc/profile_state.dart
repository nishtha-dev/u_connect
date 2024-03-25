part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final ApiStatus<UserDataModel> userData;
  final PermissionStatus galleryAccessStatus;
  final ApiStatus<bool> isUserUpdateSuccessFully;
  final ApiStatus<String> profileImageDownloadUrl;
  final UserDataModel? enteredUserData;
  final PermissionStatus cameraPermissionStatus;
  final int cameraPermissionFailureCount;
  const ProfileState({
    this.userData = const Initial<UserDataModel>(),
    this.isUserUpdateSuccessFully = const Initial<bool>(),
    this.profileImageDownloadUrl = const Initial<String>(),
    this.enteredUserData,
    this.galleryAccessStatus = PermissionStatus.granted,
    this.cameraPermissionFailureCount = 0,
    this.cameraPermissionStatus = PermissionStatus.granted,
  });

  ProfileState copyWith({
    ApiStatus<UserDataModel>? userData,
    ApiStatus<bool>? isUserUpdateSuccessFully,
    ApiStatus<String>? profileImageDownloadUrl,
    UserDataModel? enteredUserData,
    PermissionStatus? cameraPermissionStatus,
    PermissionStatus? galleryAccessStatus,
    int? cameraPermissionFailureCount,
  }) {
    return ProfileState(
      userData: userData ?? this.userData,
      isUserUpdateSuccessFully:
          isUserUpdateSuccessFully ?? this.isUserUpdateSuccessFully,
      profileImageDownloadUrl:
          profileImageDownloadUrl ?? this.profileImageDownloadUrl,
      enteredUserData: enteredUserData ?? this.enteredUserData,
      cameraPermissionStatus:
          cameraPermissionStatus ?? this.cameraPermissionStatus,
      galleryAccessStatus: galleryAccessStatus ?? this.galleryAccessStatus,
      cameraPermissionFailureCount:
          cameraPermissionFailureCount ?? this.cameraPermissionFailureCount,
    );
  }

  @override
  List<Object?> get props => [
        userData,
        enteredUserData,
        isUserUpdateSuccessFully,
        profileImageDownloadUrl,
        cameraPermissionFailureCount,
        galleryAccessStatus,
        cameraPermissionStatus
      ];
}
