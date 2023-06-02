import 'package:get/get.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:musicplayer/functions/songs.dart';

class SearchControllers extends GetxController {
  var data = <Songs>[].obs;

  search(String searchText) {
    data.value = allsongs
        .where((element) => element.songname!
            .toLowerCase()
            .contains(searchText.toLowerCase().trim()))
        .toList();
    update();
  }
}
