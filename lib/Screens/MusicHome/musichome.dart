// ignore_for_file: prefer_const_constructors

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/bottomsheet.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/Screens/favoritelist.dart';
import 'package:musicplayer/Screens/favorites.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicHome extends StatefulWidget {
  Songs song;

  MusicHome({super.key, required this.song});

  @override
  State<MusicHome> createState() => _MusicHomeState();
}

AssetsAudioPlayer currentplaying = AssetsAudioPlayer();
int? playingId;
Songs? currentlyPlaying;

class _MusicHomeState extends State<MusicHome> {
  bool isfavcolor = false;
  bool isrepeat = false;
  bool isshuffle = false;
  // int repeat = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isfavcolor = favlist.value.contains(widget.song);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: currentplaying.builderCurrent(builder: (context, Playing) {
          playingId = int.parse(Playing.audio.audio.metas.id!);

          songfind(playingId!);

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      )),
                  SizedBox(width: 30.w),
                  Container(
                    height: 250.h,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: QueryArtworkWidget(
                      size: 3000,
                      quality: 100,
                      artworkQuality: FilterQuality.high,
                      artworkBorder: const BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100)),
                      artworkFit: BoxFit.cover,
                      id: int.parse(playingId.toString()),
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(100),
                              bottomRight: Radius.circular(100)),
                          image: DecorationImage(
                              image: AssetImage('Assets/Images/thumbimg.jpg'),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 80.h),
              SizedBox(
                height: 40.h,
                width: 270.w,
                child: Marquee(
                  text: currentplaying.getCurrentAudioTitle,
                  pauseAfterRound: const Duration(seconds: 3),
                  velocity: 30,
                  blankSpace: 35,
                  style: GoogleFonts.robotoSlab(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                width: 120.w,
                child: Text(
                  currentplaying.getCurrentAudioArtist,
                  style: GoogleFonts.robotoSlab(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            if (isfavcolor == false) {
                              isfavcolor = true;
                              addfav(widget.song);
                            } else {
                              isfavcolor = false;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          size: 30,
                          color: isfavcolor
                              ? const Color.fromARGB(255, 243, 19, 3)
                              : Colors.black,
                        )),
                    IconButton(
                        onPressed: () {
                          showPlaylistModalSheet(
                              context: context, song: widget.song);
                        },
                        icon: const Icon(
                          Icons.playlist_add,
                          color: Colors.black,
                          size: 36,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, top: 0),
                child: currentplaying.builderRealtimePlayingInfos(
                    builder: (context, infos) {
                  Duration currentposition = infos.currentPosition;
                  Duration totalduration = infos.duration;
                  return ProgressBar(
                    progress: currentposition,
                    total: totalduration,
                    baseBarColor: Colors.grey,
                    thumbColor: const Color.fromARGB(255, 247, 22, 6),
                    onSeek: (to) {
                      currentplaying.seek(to);
                    },
                  );
                }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (isrepeat == false) {
                            isrepeat = true;
                            currentplaying.setLoopMode(LoopMode.single);
                          } else {
                            isrepeat = false;
                            currentplaying.setLoopMode(LoopMode.playlist);
                          }
                        });
                      },
                      icon: isrepeat
                          ? const Icon(Icons.repeat_on, color: Colors.white)
                          : const Icon(
                              Icons.repeat,
                              size: 30,
                            )),
                  SizedBox(
                    width: 60.w,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          currentplaying.toggleShuffle();
                        });
                      },
                      icon: currentplaying.isShuffling.value
                          ? const Icon(
                              Icons.shuffle_on_outlined,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.shuffle,
                              color: Colors.black,
                              size: 30,
                            )),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      onPressed: () {
                        currentplaying.previous();
                      },
                      icon: const Icon(Icons.skip_previous, size: 35)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 17),
                    child: PlayerBuilder.isPlaying(
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
                                isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_fill,
                                size: 60));
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        currentplaying.next();
                      },
                      icon: const Icon(Icons.skip_next, size: 35)),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          );
        }),
      ),
    );
  }
}
