import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/song_viewmodel.dart';
import '../widgets/custom_text.dart';
import '../widgets/main_card.dart';
import 'music_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final Song song;

  @override
  void initState() {
    song = Provider.of<Song>(context, listen: false);
    super.initState();
  }

  void navigateToSong(int? index) {}

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
          stops: [0.4, 0.9],
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
          toolbarHeight: 50.h,
          backgroundColor: Colors.transparent,
          title: CustomText(title: "Songs", fontSize: 40.sp, fontWeight: FontWeight.bold),
        ),
        body: Consumer<Song>(
          builder: (BuildContext context, data, Widget? child) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 45.h),
                  child: SizedBox(
                    height: 500.h,
                    child: ListView.builder(
                      itemCount: data.songs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h),
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
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: Container(
                                  width: double.infinity,
                                  height: 100.h,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black38.withOpacity(0.5),
                                        blurRadius: 40.r,
                                        offset: Offset(3.w, 5.h),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  song.changeMusic(index);
                                  song.currentSongIndex = index;
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => const MusicScreen()),
                                  );
                                  song.playMusic(index);
                                },
                                child: MainCard(
                                  valueOfPadding: 20.w,
                                  title: SizedBox(
                                    height: 40.h,
                                    child: CustomText(
                                      title: data.songs[index].nameOfSong,
                                      fontSize: 30.sp,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  subTitle: CustomText(
                                    title: data.songs[index].artist,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  leading: CustomText(
                                    title: index < 10 ? "0${index + 1}" : "$index",
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
