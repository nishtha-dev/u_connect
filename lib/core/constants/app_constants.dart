import 'package:flutter/material.dart';
import 'package:u_connect/core/models/models.dart';

class AppConstants {
  static final List<TabItemModel> bottomTabs = [
    TabItemModel(
      icon: const Icon(Icons.home),
      label: 'Home',
    ),
    TabItemModel(
      icon: const Icon(Icons.search),
      label: 'Search',
    ),
    TabItemModel(
      icon: const Icon(Icons.people),
      label: 'My Connections',
    ),
    TabItemModel(
      icon: const Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  static const userCollectionName = "users";
  static const defaultProfilePicUrl =
      "https://firebasestorage.googleapis.com/v0/b/fir-auth-test-3c7c2.appspot.com/o/default_profile_avatar.svg?alt=media&token=ec541668-09ea-48b4-9854-3d9dc33a6d8e";
}
