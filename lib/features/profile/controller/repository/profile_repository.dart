import 'dart:typed_data';

import 'package:u_connect/features/auth/models/user_data_model.dart';
import 'package:u_connect/features/profile/view/widgets/edit_profile_bottom_sheet.dart';

abstract class ProfileRepository {
  Future<UserDataModel> getUserProfileData();
  Future<void> updateUserProfileData({required UserData data});
  Future<String> uploadImageToCloud({required Uint8List imageFile});
}
