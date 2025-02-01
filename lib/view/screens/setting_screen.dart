import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../view_model/toggle_modes_viewmodel.dart';
import '../widgets/custom_text.dart';
import '../widgets/main_card.dart';
import '../widgets/screen_light.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // to be able to make the appBar transparent
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.transparent,
          title: Center(child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CustomText(title: "Settings" , fontSize: 40,fontWeight: FontWeight.bold,),
          )),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,

        body: Stack(
          children: [

          // the light of screen
            Positioned(
              left: -30,
              top: -160,
                child: ScreenLight()),


             // the main function to change the modes
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0 , bottom: 5.0),
                    child: Stack(children: [

                      // the light shadow of the one card
                      Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(

                          boxShadow: [
                            BoxShadow(
                              color: Colors.white30.withOpacity(0.3),
                              blurRadius: 40,
                              offset: Offset(1, 5)
                            )
                          ]
                        ),
                      ),


                      // the dark shadow of the one card
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black38.withOpacity(0.5),
                                blurRadius: 40,
                                offset: Offset(3, 5)
                              )
                            ]
                          ),
                        ),
                      ),


                      // the card itSelf
                      Consumer<ToggleModes>(builder: (context , data , child){
                        // use main card component
                      return MainCard(
                          valueOfPadding: 20.0,
                          title: CustomText(title: "Light Mode" , fontSize: 30, fontWeight: FontWeight.bold,),
                          leading: Icon(
                            FontAwesomeIcons.lightbulb , size: 37,
                          ),
                          trailing: CupertinoSwitch(value: data.isCheck,
                            onChanged: (value) {
                              data.changeModes();
                            }),
                      );
                    }),



                    ],),
                  ),
                ],
              ),
            ),
              


          ],
        ),
      ),
    );
  }
}
