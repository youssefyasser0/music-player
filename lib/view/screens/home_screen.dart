import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../view_model/song_viewmodel.dart';
import '../widgets/custom_text.dart';
import '../widgets/main_card.dart';
import '../widgets/screen_light.dart';
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
    song = Provider.of<Song>(context , listen: false);
    super.initState();
  
  }
  void navigateToSong(int? index) {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        title: CustomText(title: "Songs" , fontSize: 40,fontWeight: FontWeight.bold,),
      ),
      // backgroundColor: Theme.of(context).colorScheme.surface,
      body: Consumer<Song>(
        builder: (BuildContext context, data, Widget? child) {

            return  Stack(
          children: [
            // light of screen
            Positioned(
                left: -30,
                top: -160,
                child: ScreenLight()),

            // the songs
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: ListView.builder(
                itemCount: data.songs.length,
                itemBuilder: (context , index){
        
                  return Padding(
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
                      GestureDetector(
                        onTap: () {

                          // to mark the playing song
                          song.changeMusic(index);

                          // get the index
                          song.currentSongIndex = index;

                          // navigate to music screen
                          Navigator.of(context).push(
                              MaterialPageRoute(builder:
                                  (context) => MusicScreen()) );

                          // play music
                          song.playMusic(index);
                        },
                        child: MainCard(
                          valueOfPadding: 20.0,
                          title: SizedBox(
                            height: 40
                            ,child: CustomText(title:  data.songs[index].nameOfSong,
                            fontSize: 30, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,)),
                          subTitle: CustomText(title: data.songs[index].artist,color: Colors.grey,fontWeight: FontWeight.bold,),
                          leading: CustomText(title: index < 10 ?  "0${index + 1}" : "$index" ,
                            fontSize: 25, fontWeight: FontWeight.bold,),
                          trailing: Visibility(
                            visible: data.showPause[index],
                            child: Icon(
                              FontAwesomeIcons.pause , size: 30,
                            ),
                          ),
                        ),
                      ),
        
        
        
                    ],),
                  );
                },
        
              ),
            ),
        
        
          ],
        );
         },
      ),
    );
  }
}