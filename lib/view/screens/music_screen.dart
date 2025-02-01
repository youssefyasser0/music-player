import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../view_model/song_viewmodel.dart';
import '../widgets/custom_text.dart';
import '../widgets/screen_light.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {

  late final Song storage;

  // convert time of music
    String changeMusicTime(Duration duration) {
      String convertTime = duration.inSeconds.remainder(60).toString().padLeft(2 , "0");
      String inMinAndSec = "${duration.inMinutes}:$convertTime";
      return inMinAndSec;
    }

  @override
  void initState() {
    storage = Provider.of<Song>(context , listen: false);

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 65,
              toolbarHeight: 60,
              leading: GestureDetector(
                  onTap: () => Navigator.pop(context) ,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0 , bottom: 7 , top: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(60),
                      boxShadow:  [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.surface,
                          offset: Offset(3, 4),
                          blurRadius: 3
                        )
                      ]
                    ),
                        child: const Icon(
                          FontAwesomeIcons.arrowLeft
                        ),

                  ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: CustomText(title:  storage.songs[storage.currentSongIndex!].nameOfSong, fontSize: 40,
                      fontWeight: FontWeight.bold,
                ),
              ),
          ),
        body:

            Consumer<Song>(builder: (BuildContext context, data, Widget? child){
              return Stack(
                children: [

                  // screen light
                  Positioned(
                      left: -30,
                      top: -160,
                      child: ScreenLight()),

                  // song (image - settings)
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // song image
                          Container(
                            width: 250,
                            height: 430,
                            decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(200),
                                image: DecorationImage(
                                    fit: BoxFit.cover,image: AssetImage(
                                    storage.songs[storage.currentSongIndex!].songImage
                                )),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context).colorScheme.surface,
                                      offset: Offset(2, 3),
                                      blurRadius: 5,
                                      spreadRadius: 2
                                  )
                                ]
                            ),

                          ),

                          // song settings
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Container(
                              width: widthOfScreen * 0.9,
                              height: 230,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.background,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).colorScheme.surface ,
                                        blurRadius: 2,
                                        spreadRadius: 2,
                                        offset: Offset(1, 2)
                                    )
                                  ]
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  spacing: 12,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(title: storage.songs[storage.currentSongIndex!].artist ,fontSize: 20, fontWeight: FontWeight.bold, ),
                                        Icon(FontAwesomeIcons.solidHeart , size: 35,)
                                      ],
                                    ),

                                      // duration
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: 40,
                                            child: CustomText(title: changeMusicTime(data.currentDuration))),
                                        Icon(Icons.shuffle),
                                        Icon(Icons.repeat),
                                        SizedBox(
                                            width: 40,
                                            child: CustomText(title: changeMusicTime(data.totalDuration))),
                                      ],
                                    ),

                                      // the slider
                                    SliderTheme(
                                      data: SliderTheme.of(context).copyWith(
                                        trackHeight: 8,
                                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0)
                                      ),
                                      child: Slider(
                                        onChangeEnd: (value){
                                          data.specificPosition(Duration(seconds: value.toInt()));
                                        },

                                        value: data.currentDuration.inSeconds.toDouble(),
                                        onChanged: (value){
                                        },
                                        min: 0,max: data.totalDuration.inSeconds.toDouble(),activeColor: Colors.red,inactiveColor: Colors.white30,
                                      ),
                                    ),

                                    // music settings === >(pause - back - next)
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor: WidgetStateProperty.all(Colors.red),
                                              )
                                              ,onPressed: (){
                                                    data.backSong();
                                          },
                                              child: Icon(Icons.skip_previous , size: 26,)),
                                          SizedBox(
                                            height: 80,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor: WidgetStateProperty.all(Colors.red),
                                                )
                                                ,onPressed: (){
                                                data.pauseOrResume();
                                            },
                                                child: Icon(data.isPlaying ? Icons.pause : Icons.play_arrow , size: 30,)),
                                          ),
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor: WidgetStateProperty.all(Colors.red),
                                              )
                                              ,onPressed: () {
                                                print("grwr");
                                                data.nextMusic();
                                          },
                                              child: Icon(Icons.skip_next , size: 26,)),
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                  ),


                ],

              );
            })

      ),
    );
  }
}
