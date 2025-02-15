import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/song_viewmodel.dart';
import '../widgets/custom_text.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  late final Song storage;

  String changeMusicTime(Duration duration) {
    String convertTime = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "${duration.inMinutes}:$convertTime";
  }

  @override
  void initState() {
    storage = Provider.of<Song>(context, listen: false);
    super.initState();
  }

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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 65.w,
            toolbarHeight: 60.h,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.only(left: 15.w, bottom: 7.h, top: 3.h),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(60.r),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.surface,
                        offset: const Offset(3, 4),
                        blurRadius: 3,
                      )
                    ],
                  ),
                  child: const Icon(FontAwesomeIcons.arrowLeft),
                ),
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: CustomText(
                title: storage.songs[storage.currentSongIndex!].nameOfSong,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Consumer<Song>(builder: (context, data, child) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 35.h),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // song image
                        Padding(
                          padding: EdgeInsets.only(top: 16.h),
                          child: Container(
                            width: 245.w,
                            height: 355.h,
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(200.r),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  storage.songs[storage.currentSongIndex!].songImage,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.surface,
                                  offset: const Offset(2, 3),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                )
                              ],
                            ),
                          ),
                        ),



                        Padding(
                          padding: EdgeInsets.only(top: 17.h),
                          child: Container(
                            width: 0.9.sw,
                            height: 230.h,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.surface,
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                  offset: const Offset(1, 2),
                                )
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                spacing: 11.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        title: storage.songs[storage.currentSongIndex!].artist,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      Icon(FontAwesomeIcons.solidHeart, size: 35.sp),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(width: 40.w, child: CustomText(title: changeMusicTime(data.currentDuration))),
                                      const Icon(Icons.shuffle),
                                      const Icon(Icons.repeat),
                                      SizedBox(width: 40.w, child: CustomText(title: changeMusicTime(data.totalDuration))),
                                    ],
                                  ),
                                  SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 8.h,
                                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                                    ),
                                    child: Slider(
                                      onChangeEnd: (value) {
                                        data.specificPosition(Duration(seconds: value.toInt()));
                                      },
                                      value: data.currentDuration.inSeconds.toDouble(),
                                      onChanged: (value) {},
                                      min: 0,
                                      max: data.totalDuration.inSeconds.toDouble(),
                                      activeColor: Colors.red,
                                      inactiveColor: Colors.white30,
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: WidgetStateProperty.all(Colors.red),
                                          ),
                                          onPressed: () => data.backSong(),
                                          child: Icon(Icons.skip_previous, size: 26.sp),
                                        ),
                                        SizedBox(
                                          height: 70.h,
                                          child: ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all(Colors.red),
                                            ),
                                            onPressed: () => data.pauseOrResume(),
                                            child: Icon(data.isPlaying ? Icons.pause : Icons.play_arrow, size: 30.sp),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor: WidgetStateProperty.all(Colors.red),
                                          ),
                                          onPressed: () => data.nextMusic(),
                                          child: Icon(Icons.skip_next, size: 26.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
