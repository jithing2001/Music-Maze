import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:musicplayer/model/favmodel.dart';

class FavController extends GetxController {
  var favlist = <Songs>[].obs;

  addfav(Songs song) async {
    if (!favlist.contains(song)) {
      favlist.add(song);
      Box<Favmodel> favdb = await Hive.openBox('favorites');
      Favmodel temp = Favmodel(id: song.id);
      favdb.add(temp);
      favdb.close();
    }
  }

  removefav(Songs songs) async {
    favlist.remove(songs);
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
}
