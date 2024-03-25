import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:u_connect/core/constants/app_constants.dart';
import 'package:u_connect/features/auth/models/user_data_model.dart';
import 'package:u_connect/features/profile/controller/repository/profile_repository.dart';
import 'package:u_connect/features/profile/view/widgets/edit_profile_bottom_sheet.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final FirebaseFirestore _fireStoreDB = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final storageRef =
      FirebaseStorage.instanceFor(bucket: "gs://u-connect-934b5.appspot.com")
          .ref();

  @override
  Future<UserDataModel> getUserProfileData() async {
    final String userId = _auth.currentUser?.uid ?? '';
    DocumentSnapshot<Map<String, dynamic>> docSnapshotData = await _fireStoreDB
        .collection(AppConstants.userCollectionName)
        .doc(userId)
        .get();
    final UserDataModel userData =
        UserDataModel.fromJson(docSnapshotData.data() ?? {});
    return userData;
  }

  @override
  Future<void> updateUserProfileData({required UserData data}) async {
    final String userId = _auth.currentUser?.uid ?? '';

    final UserDataModel model = UserDataModel(
        name: data.userName,
        bio: data.bio,
        description: data.headline,
        proNoun: data.proNoun,
        customPronoun: data.customPronoun);
    await _fireStoreDB
        .collection(AppConstants.userCollectionName)
        .doc(userId)
        .update(model.toJson());
  }

  @override
  Future<String> uploadImageToCloud({required Uint8List imageFile}) async {
    final pickedImageReference = storageRef.child("images/profile_image.jpg");
    final String userId = _auth.currentUser?.uid ?? '';
    try {
      await pickedImageReference.putData(imageFile).whenComplete(() {
        return null;
      });

      String downloadUrl = await pickedImageReference.getDownloadURL();
      _fireStoreDB
          .collection(AppConstants.userCollectionName)
          .doc(userId)
          .update({"avatar": downloadUrl});
      return downloadUrl;
    } on FirebaseException {
      return '';
    }
  }
}
