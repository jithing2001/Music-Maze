import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/Screens/favorites.dart';
import 'package:musicplayer/database/favmodel.dart';
import 'package:musicplayer/functions/songs.dart';

addfav(Songs song) async {
  if (!favlist.value.contains(song)) {
    favlist.value.add(song);
    Box<Favmodel> favdb = await Hive.openBox('favorites');
    Favmodel temp = Favmodel(id: song.id);
    favdb.add(temp);
    favdb.close();
  }
}

removefav(Songs songs) async {
  favlist.value.remove(songs);
  List<Favmodel> templist = [];
  Box<Favmodel> favdb = await Hive.openBox('favorites');
  templist.addAll(favdb.values);
  for (var element in templist) {
    if (element.id == songs.id) {
      var key = element.key;
      favdb.delete(key);
      break;
    }
  }
}
