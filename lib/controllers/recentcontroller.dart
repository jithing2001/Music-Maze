import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/functions/songs.dart';

class RecentController extends GetxController{

  var recentSongs = <Songs>[].obs;

  addrecent(Songs song) async {
  Box<int> recentdb = await Hive.openBox('recent');
  List<int> temp = [];
  temp.addAll(recentdb.values);

  if (recentSongs.contains(song)) {
    recentSongs.remove(song);
    recentSongs.insert(0, song);

    for (int i = 0; i < temp.length; i++) {
      if (song.id == temp[i]) {
        recentdb.deleteAt(i);
        recentdb.add(song.id!);
      }
    }
  } else {
    recentSongs.insert(0, song);
    recentdb.add(song.id!);
  }

  if (recentSongs.length > 10) {
    recentSongs.value = recentSongs.sublist(0, 10);
    recentdb.deleteAt(0);
  }
}
}