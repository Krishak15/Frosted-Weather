import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:weatherapp_frosted/screen/altitude_pressure.dart';
import 'package:weatherapp_frosted/screen/forecast_page.dart';
import 'package:weatherapp_frosted/screen/home_page.dart';

class BottomNavBarClass extends StatefulWidget {
  const BottomNavBarClass({super.key});

  @override
  State<BottomNavBarClass> createState() => _BottomNavBarClassState();
}

class _BottomNavBarClassState extends State<BottomNavBarClass> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

//Screens
  List<Widget> _buildScreens() {
    return [const HomePage(), const ForecastPage(), const AltPressurePage()];
  }

  //Navbar items
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Current"),
        activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cloud_bolt),
        title: ("Forecast"),
        activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.gauge),
        title: ("Altitude"),
        activeColorPrimary: const Color.fromARGB(255, 255, 255, 255),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),

      confineInSafeArea: true,

      backgroundColor: Colors.black, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true,
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.black,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: false,
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property.
    );
  }
}
