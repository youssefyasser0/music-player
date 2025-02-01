import 'package:flutter/material.dart';
import 'package:music/view/screens/change_screen.dart';
import 'package:music/view_model/song_viewmodel.dart';
import 'package:music/view_model/toggle_modes_viewmodel.dart';
import 'package:provider/provider.dart';
import 'constants/dark_mode.dart';
import 'constants/light_mode.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ToggleModes()), 
          ChangeNotifierProvider(create: (context) => Song()),
        ],
          child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ToggleModes>( 
      builder: (context, toggleModes, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: toggleModes.isCheck ? lightMode : darkMode, 
          home: ChangeScreen(),
        );
      },
    );
  }
}



