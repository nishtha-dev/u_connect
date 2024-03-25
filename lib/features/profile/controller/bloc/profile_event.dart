part of 'profile_bloc.dart';

class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserData extends ProfileEvent {
  const GetUserData();
}

class UpdateUserData extends ProfileEvent {
  final UserData userData;
  const UpdateUserData({required this.userData});
}

class SaveEnteredUserData extends ProfileEvent {
  final UserDataModel userData;
  const SaveEnteredUserData({required this.userData});
}

class SelectImage extends ProfileEvent {
  const SelectImage();
}

class CaptureImage extends ProfileEvent {
  const CaptureImage();
}

class UploadImage extends ProfileEvent {
  final XFile? capturedImage;
  const UploadImage({this.capturedImage});
}
