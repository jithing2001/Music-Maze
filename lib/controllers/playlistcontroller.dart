import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/functions/eachplaylist.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:musicplayer/model/playlist_model.dart';

class PlaylistController extends GetxController {
  var playlistlist = <EachPlaylist>[].obs;

  Future playlistCreating(playlistName) async {
    playlistlist.add(EachPlaylist(name: playlistName));
    Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');
    playlistdb.add(PlaylistClass(playlistName: playlistName));
    playlistdb.close();
  }

  Future playlistSongsAddDB(Songs addingSong, String playlistName) async {
    Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');

    for (PlaylistClass element in playlistdb.values) {
      if (element.playlistName == playlistName) {
        var key = element.key;
        PlaylistClass updatePlaylist =
            PlaylistClass(playlistName: playlistName);
        updatePlaylist.songsId.addAll(element.songsId);
        updatePlaylist.songsId.add(addingSong.id!);
        playlistdb.put(key, updatePlaylist);
        break;
      }
    }

    playlistdb.close();
  }

  Future playlistRemoveDB(Songs removingSong, String playlistName) async {
    Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');
    for (PlaylistClass element in playlistdb.values) {
      if (element.playlistName == playlistName) {
        var key = element.key;
        PlaylistClass updatePlaylist =
            PlaylistClass(playlistName: playlistName);
        for (int item in element.songsId) {
          if (item == removingSong.id) {
            continue;
          }
          updatePlaylist.songsId.add(item);
        }
        playlistdb.put(key, updatePlaylist);
        break;
      }
    }
  }

  Future playlistdelete(int index) async {
    String playlistname = playlistlist[index].name;
    Box<PlaylistClass> playlistdb = await Hive.openBox('playlist');
    for (PlaylistClass element in playlistdb.values) {
      if (element.playlistName == playlistname) {
        var key = element.key;
        playlistdb.delete(key);
        break;
      }
    }
    playlistlist.removeAt(index);
  }
}
