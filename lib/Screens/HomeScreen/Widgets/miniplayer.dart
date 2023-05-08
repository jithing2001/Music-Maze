import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:musicplayer/Screens/MusicHome/musichome.dart';
import 'package:musicplayer/Screens/Playlist/playlistsongs.dart';
import 'package:musicplayer/Screens/RecentScreen/recentscreen.dart';
import 'package:musicplayer/Screens/Settings/settings.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:musicplayer/functions/recentfunction.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  String img;

  List<Songs> songs = [];
  List<Audio> playinglistAudio = [];
  int index;
  bool prevvisible = true;
  bool nxtvisible = true;

  IconData icon1;
  IconData icon2;
  IconData icon3;
  MiniPlayer({
    required this.img,
    required this.songs,
    required this.index,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    super.key,
  }) {
    currentlyPlaying = songs[0];
    for (int i = 0; i < songs.length; i++) {
      playinglistAudio.add(Audio.file(songs[i].songurl!,
          metas: Metas(
            title: songs[i].songname,
            artist: songs[i].artist,
            id: songs[i].id.toString(),
          )));
    }
  }

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool prevvisible = true;
  bool nxtvisible = true;
  bool nextDone = true;
  bool preDone = true;

  buttondesable() {
    if (widget.index == 0) {
      prevvisible = false;
    } else {
      prevvisible = true;
    }

    if (widget.index == songs.length - 1) {
      nxtvisible = false;
    } else {
      nxtvisible = true;
    }
  }

  void initState() {
    currentplaying.open(
      Playlist(audios: widget.playinglistAudio, startIndex: widget.index),
      autoStart: true,
      showNotification: notification,
      playInBackground: PlayInBackground.enabled,
      audioFocusStrategy: const AudioFocusStrategy.request(
          resumeAfterInterruption: true, resumeOthersPlayersAfterDone: true),
      headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
    );
    currentplaying.setLoopMode(LoopMode.playlist);
    buttondesable();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MusicHome(
                  song: widget.songs[widget.index],
                )));
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
            child: currentplaying.builderCurrent(builder: (context, Playing) {
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
                      text: currentplaying.getCurrentAudioTitle,
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
                      prevvisible
                          ? Visibility(
                              visible: prevvisible,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() async {
                                      widget.index = widget.index - 1;
                                      if (widget.index != songs.length - 1) {
                                        nxtvisible = true;
                                      }
                                      if (preDone) {
                                        preDone = false;
                                        await currentplaying.previous();
                                        preDone = true;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    widget.icon1,
                                    size: 30,
                                  )),
                            )
                          : SizedBox(
                              width: 30.w,
                            ),
                      PlayerBuilder.isPlaying(
                        player: currentplaying,
                        builder: (context, isPlaying) {
                          return IconButton(
                              onPressed: () {
                                setState(() {
                                  isPlaying = !isPlaying;
                                  currentplaying.playOrPause();
                                });
                              },
                              icon: Icon(
                                isPlaying ? Icons.pause : Icons.play_arrow,
                                size: 30,
                              ));
                        },
                      ),
                      nxtvisible
                          ? Visibility(
                              visible: nxtvisible,
                              child: IconButton(
                                  onPressed: () {
                                    setState(() async {
                                      widget.index = widget.index + 1;
                                      if (widget.index > 0) {
                                        prevvisible = true;
                                      }
                                      if (nextDone) {
                                        nextDone = false;
                                        await currentplaying.next();
                                        nextDone = true;
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    widget.icon3,
                                    size: 30,
                                  )),
                            )
                          : SizedBox(
                              width: 30.w,
                            )
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
  addrecent(currentlyPlaying!);
}
