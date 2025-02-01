import 'dart:core';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../model/song_model.dart';

class Song with ChangeNotifier{

  // List of songs
    List<SongModel> songs = [
       SongModel(id: "1", nameOfSong: "Wild Flower",
        artist: "Billie Eilish", 
        songImage: "assets/images/billie-eilish-hit-me-hard-and-soft-album-2024-cover.jpg",
         song: "audio/Billie Eilish - WILDFLOWER (Official Lyric Video).mp3") ,

         SongModel(id: "2", nameOfSong: "Lovely",
        artist: "Billie Eilish", 
        songImage: "assets/images/R.jpg",
         song: "audio/Billie Eilish, Khalid - lovely.mp3") ,

         SongModel(id: "3", nameOfSong: "Eyes don't Lie",
        artist: "Isabel Larosa", 
        songImage: "assets/images/maxresdefault.jpg",
         song: "audio/Isabel LaRosa - eyes don’t lie (slowed + reverb).mp3") ,

         
    ];

    List<SongModel> songStorage = [];

    // get the index of the song
    int? _currentSongIndex;

    // getter
    int? get currentSongIndex => _currentSongIndex;

    // setter
    set currentSongIndex(int? newIndex){
      _currentSongIndex = newIndex;

      if(newIndex != null){
        playMusic(newIndex);
      }

      notifyListeners();
    }

    // get fav storage index
    int? _favIndex;

    int? get favIndex => _favIndex;

    void getIndex(int index) {
      _favIndex = index;
      notifyListeners();
    }


  // booleans to know which song is playing
    late List<bool> showPause = List.filled(songs.length, false);


  // Audio Player
    AudioPlayer audioPlayer = AudioPlayer();

    Song(){
      listenToChanges();
    }

    // check for playing
      bool isPlaying = false;

    // play music
      playMusic(int index){
        String musicPath = songs[index].song;
        audioPlayer.stop();
        audioPlayer.play(AssetSource(musicPath));
        isPlaying = true;
        notifyListeners();
      }

    // pause
      pauseMusic() async{
        await audioPlayer.pause();
        isPlaying = false;
        notifyListeners();
      }

    // resume
      resumeMusic() async{
        await audioPlayer.resume();
        isPlaying = true;
        notifyListeners();
      }

    // pause Or resume
      void pauseOrResume() {
        if(isPlaying){
          pauseMusic();
        }else{
          resumeMusic();
        }
        notifyListeners();
      }

    // play in specific position
      void specificPosition(Duration seekDuration) async{
        await audioPlayer.seek(seekDuration);
      }

    // next music
      void nextMusic() async{
        if(_currentSongIndex != null){
          if(_currentSongIndex! < songs.length - 1){
            currentSongIndex = _currentSongIndex! + 1;
            notifyListeners();
          }else{
            currentSongIndex = 0;
          }
        }
      }

    // back song
      void backSong() {
        if(currentDuration.inSeconds < 2){
            specificPosition(Duration.zero);
        }else{
          if(currentSongIndex! > 0){
            currentSongIndex = _currentSongIndex! - 1;
            notifyListeners();
          }else{
            currentSongIndex = songs.length - 1;
          }
        }
      }


    // current duration
    Duration currentDuration = Duration.zero;

    // total duration
    Duration totalDuration = Duration.zero;

    void listenToChanges() {
      // stream listen to music from begin change
        audioPlayer.onPositionChanged.listen((isDuration){
          currentDuration = isDuration;
          notifyListeners();
        });


       // stream listen to music total change
        audioPlayer.onDurationChanged.listen((isDuration){
          totalDuration = isDuration;
          notifyListeners();
        });

       // after music is completed play the next song
        audioPlayer.onPlayerComplete.listen((isDuration){
            nextMusic();
        });

    }



  // function to know which song is playing
    changeMusic(int index) {

          showPause = List.filled(songs.length, false);
          showPause[index] = true;
          notifyListeners();

    }





}