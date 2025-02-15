import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:music/view/screens/setting_screen.dart';
import 'home_screen.dart';


class ChangeScreen extends StatefulWidget {
  const ChangeScreen({super.key});

  @override
  State<ChangeScreen> createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {

  int screenIndex = 0;
  // Color themeColor = Theme.of(context).colorScheme.primary;
  
  // the screens
  List screens = [
    const HomeScreen(),
    const SettingScreen()
  ];
  
  @override
  Widget build(BuildContext context) {
    // navigation bar items
      List<BottomNavigationBarItem> items =[
    BottomNavigationBarItem(icon: Icon(
    FontAwesomeIcons.music ,color: Theme.of(context).colorScheme.primary,
    ) , label: ""),
    BottomNavigationBarItem(icon: Icon(
    FontAwesomeIcons.edit  ,color: Theme.of(context).colorScheme.primary
    ) , label: "" ),
    ];

     return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 20,
          currentIndex: screenIndex,
          items: items,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap:(screen){
            setState(() {
              screenIndex = screen;
            });
          } ,

      ),
      body: screens[screenIndex],
    );
  }
}
