import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/Screens/RecentScreen/recentscreen.dart';
import 'package:musicplayer/functions/songs.dart';

addrecent(Songs song) async {
  Box<int> recentdb = await Hive.openBox('recent');
  List<int> temp = [];
  temp.addAll(recentdb.values);

  if (recentSongs.value.contains(song)) {
    recentSongs.value.remove(song);
    recentSongs.value.insert(0, song);

    for (int i = 0; i < temp.length; i++) {
      if (song.id == temp[i]) {
        recentdb.deleteAt(i);
        recentdb.add(song.id!);
      }
    }
  } else {
    recentSongs.value.insert(0, song);
    recentdb.add(song.id!);
  }

  if (recentSongs.value.length > 10) {
    recentSongs.value = recentSongs.value.sublist(0, 10);
    recentdb.deleteAt(0);
  }
  recentSongs.notifyListeners();
}
