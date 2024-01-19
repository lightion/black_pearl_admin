import 'package:black_pearl/presentation/dashboard/home/screen/home_screen.dart';
import 'package:black_pearl/presentation/dashboard/list/screen/list_screen.dart';
import 'package:black_pearl/presentation/dashboard/profile/screen/profile_screen.dart';
import 'package:core/constants/app_constants.dart';
import 'package:core/constants/string_constants.dart';
import 'package:core/theme/color_constants.dart';
import 'package:core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isDoublePressed = false;

  /// List of the screen to be displayed on bottom navigation
  static final List<Widget> _widgetOption = <Widget>[
    const HomeScreen(),
    const ListScreen(),
    const ProfileScreen(),
  ];

  static final List<BottomNavigationBarItem> _bottomNavigationBarItem =
      <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: StringConstants.home,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.list),
      label: StringConstants.list,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: StringConstants.profile,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      AppConstants.indexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        backgroundColor: ColorConstants.antiFlashWhite,
        appBar: AppBarWidget(
          message: "",
          backgroundColor: ColorConstants.white,
        ),
        body: Center(
          child: _widgetOption.elementAt(AppConstants.indexPage),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomNavigationBarItem,
          currentIndex: AppConstants.indexPage,
          selectedItemColor: ColorConstants.electricBlue,
          unselectedItemColor: ColorConstants.gray50,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
