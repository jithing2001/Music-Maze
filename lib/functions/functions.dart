import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/Screens/Playlist/playlist.dart';
import 'package:musicplayer/Screens/Settings/settings.dart';
import 'package:musicplayer/Screens/favorites.dart';
import 'package:musicplayer/database/favmodel.dart';
import 'package:musicplayer/database/playlist_model.dart';
import 'package:musicplayer/functions/eachplaylist.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

List<Songs> allsongs = [];
Audio find(List<Audio> sourse, String fromPath) {
  return sourse.firstWhere((element) => element.path == fromPath);
}

class Functions {
  final _audioquery = OnAudioQuery();

  fetchSongs() async {
    if (await requestPermission()) {
      List<SongModel> fetchsongs = [];
      fetchsongs = await _audioquery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true);

      for (SongModel element in fetchsongs) {
        allsongs.add(Songs(
          songname: element.displayNameWOExt,
          artist: element.artist,
          duration: element.duration,
          id: element.id,
          songurl: element.uri,
        ));
      }
    }
  }

  favFetching() async {
    List<Favmodel> favsongs = [];
    Box<Favmodel> favdb = await Hive.openBox('favorites');

    favsongs.addAll(favdb.values);

    for (var fav in favsongs) {
      int count = 0;
      for (var songs in allsongs) {
        if (fav.id == songs.id) {
          favc.favlist.value.add(songs);
          continue;
        } else {
          count++;
        }
      }
      if (count == allsongs.length) {
        var key = fav.key;
        favdb.delete(key);
      }
    }
  }

  recentFetching() async {
    Box<int> recentdb = await Hive.openBox('recent');
    List<Songs> recentlist = [];

    for (var element in recentdb.values) {
      for (Songs songs in allsongs) {
        if (element == songs.id) {
          recentlist.add(songs);
          break;
        }
      }
     recentc.recentSongs.value = recentlist.reversed.toList();
    }
  }

  playlistfetching() async {
    Box<PlaylistClass> playlistDB = await Hive.openBox('playlist');
    for (PlaylistClass play in playlistDB.values) {
      EachPlaylist item = EachPlaylist(name: play.playlistName);
      playc.playlistlist.value.add(item);
      for (int id in play.songsId) {
        for (Songs song in allsongs) {
          if (id == song.id) {
            item.songlist.add(song);
          }
        }
      }
    }

  }

  Future notificationFetching() async {
    Box<bool> notifydb = await Hive.openBox('notification');
    if (notifydb.isEmpty) {
      notification = true;
    } else {
      for (var element in notifydb.values) {
        notification = element;
      }
    }
  }
}

Future<bool> requestPermission() async {
  PermissionStatus status = await Permission.storage.request();
  if (status.isGranted) {
    return true;
  } else {
    return false;
  }
}
