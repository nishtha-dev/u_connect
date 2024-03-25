import 'package:flutter/material.dart';
import 'package:u_connect/features/home/view/bottom_tab_bar_view.dart';
import 'package:u_connect/features/profile/view/screens/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndexValue = 3;
  static const List<Widget> _pages = <Widget>[
    SizedBox(),
    SizedBox(),
    SizedBox(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _pages.elementAt(selectedIndexValue),
      bottomNavigationBar: BottomTabBarView(
        selectedIndex: selectedIndexValue,
        onTap: (int currentIndex) {
          setState(() {
            selectedIndexValue = currentIndex;
          });
        },
      ),
    );
  }
}
