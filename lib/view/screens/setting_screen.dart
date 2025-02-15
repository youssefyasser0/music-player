import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/toggle_modes_viewmodel.dart';
import '../widgets/custom_text.dart';
import '../widgets/main_card.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.background,
            Colors.white12,
          ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          stops: [0.3, 0.7],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 50.h,
            backgroundColor: Colors.transparent,
            title: Padding(
              padding: EdgeInsets.only(top: 8.0.h),
              child: CustomText(
                title: "Settings",
                fontSize: 40.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100.0.h),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5.0.h, bottom: 5.0.h),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 50.h,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white30.withOpacity(0.3),
                                  blurRadius: 40.r,
                                  offset: Offset(1.w, 5.h),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15.0.h),
                            child: Container(
                              width: double.infinity,
                              height: 100.h,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black38.withOpacity(0.5),
                                    blurRadius: 40.r,
                                    offset: Offset(3.w, 5.h),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Consumer<ToggleModes>(
                            builder: (context, data, child) {
                              return MainCard(
                                valueOfPadding: 20.0.w,
                                title: CustomText(
                                  title: "Light Mode",
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                leading: Icon(
                                  FontAwesomeIcons.lightbulb,
                                  size: 37.sp,
                                ),
                                trailing: CupertinoSwitch(
                                  value: data.isCheck,
                                  onChanged: (value) {
                                    data.changeModes();
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
