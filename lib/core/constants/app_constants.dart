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
}
