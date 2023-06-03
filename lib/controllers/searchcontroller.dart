import 'package:get/get.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:musicplayer/functions/songs.dart';

class SearchControllers extends GetxController {
  var data = <Songs>[];

  search(String searchText) {
    data = allsongs
        .where((element) => element.songname!
            .toLowerCase()
            .contains(searchText.toLowerCase().trim()))
        .toList();
    update();
  }
}
