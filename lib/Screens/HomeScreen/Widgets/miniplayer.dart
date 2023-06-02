import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:musicplayer/Screens/MusicHome/musichome.dart';
import 'package:musicplayer/Screens/Settings/settings.dart';
import 'package:musicplayer/controllers/recentcontroller.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

List<Audio> playinglistAudio = [];
RecentController recentc = Get.put(RecentController());

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({
    super.key,
  });

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}



class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(const MusicHome());
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.11,
        width: double.infinity,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Color.fromARGB(255, 142, 161, 169),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: player.builderCurrent(builder: (context, Playing) {
              playingId = int.parse(Playing.audio.audio.metas.id!);
              songfind(playingId!);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: QueryArtworkWidget(
                        size: 3000,
                        quality: 100,
                        artworkQuality: FilterQuality.high,
                        artworkBorder: BorderRadius.circular(10),
                        artworkFit: BoxFit.cover,
                        keepOldArtwork: true,
                        id: int.parse(playingId.toString()),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'Assets/Images/thumbimg.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                    width: 120.w,
                    child: Marquee(
                      text: player.getCurrentAudioTitle,
                      pauseAfterRound: const Duration(seconds: 5),
                      velocity: 30,
                      blankSpace: 35,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.0015,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() async {
                              await player.previous();
                            });
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            size: 30,
                          )),
                      PlayerBuilder.isPlaying(
                        player: player,
                        builder: (context, isPlaying) {
                          return IconButton(
                              onPressed: () {
                                setState(() {
                                  isPlaying = !isPlaying;
                                  player.playOrPause();
                                });
                              },
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 30,
                              ));
                        },
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() async {
                              await player.next();
                            });
                          },
                          icon: const Icon(
                            Icons.skip_next,
                            size: 30,
                          ))
                    ],
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

songfind(int playid) {
  for (Songs song in allsongs) {
    if (song.id == playid) {
      currentlyPlaying = song;
      break;
    }
  }
  recentc.addrecent(currentlyPlaying!);
}

playsong(int index, List<Songs> songlist) {
  player.stop();
  playinglistAudio.clear();
  currentlyPlaying = songlist[index];
  for (int i = 0; i < songlist.length; i++) {
    playinglistAudio.add(Audio.file(songlist[i].songurl!,
        metas: Metas(
          title: songlist[i].songname,
          artist: songlist[i].artist,
          id: songlist[i].id.toString(),
        )));
  }
  player.open(
    Playlist(audios: playinglistAudio, startIndex: index),
    autoStart: true,
    showNotification: notification,
    playInBackground: PlayInBackground.enabled,
    audioFocusStrategy: const AudioFocusStrategy.request(
        resumeAfterInterruption: true, resumeOthersPlayersAfterDone: true),
    headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
  );
  player.setLoopMode(LoopMode.playlist);
}
