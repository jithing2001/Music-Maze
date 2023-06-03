import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:musicplayer/view/favorites.dart';

class FavIconController extends GetxController {
  RxBool isfav = false.obs;

  iconFunction(Songs song, BuildContext context) {
    if (favc.favlist.contains(song)) {
      isfav.value = false;
      favc.removefav(song);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Song removed from favorites'),
        duration: Duration(seconds: 2),
      ));
    } else {
      isfav.value = true;

      favc.addfav(song);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Song added to favorites'),
        duration: Duration(seconds: 2),
      ));
    }
    Get.back();
  }
}
