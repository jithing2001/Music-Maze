import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicplayer/view/MusicHome/musichome.dart';
import 'package:musicplayer/view/favorites.dart';

class NowPlayingController extends GetxController {
  RxBool isfavcolor = false.obs;
  RxBool isrepeat = false.obs;
  RxBool isShuffle = false.obs;
  RxBool isPlaying = false.obs;

  nowPlayingFavIcon(BuildContext context) {
    if (favc.favlist.contains(currentlyPlaying)) {
      isfavcolor.value = false;
      favc.removefav(currentlyPlaying!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Song removed from favorites'),
        duration: Duration(seconds: 2),
      ));
    } else {
      isfavcolor.value = true;
      favc.addfav(currentlyPlaying!);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Song added to favorites'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  repeatFunction() {
    if (isrepeat == false) {
      isrepeat.value = true;
      player.setLoopMode(LoopMode.single);
    } else {
      isrepeat.value = false;
      player.setLoopMode(LoopMode.playlist);
    }
  }

  playPause() {
    isPlaying.value = !isPlaying.value;
  }

  shuffleFunction(bool value) {
    isShuffle.value = value;
  }

  //  void checkFavColor(bool containsCurrentlyPlaying) {
  //   isFavColor.value = containsCurrentlyPlaying;
  // }
}
