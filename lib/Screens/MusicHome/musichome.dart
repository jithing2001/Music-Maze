import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/bottomsheet.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/Screens/favorites.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicHome extends StatefulWidget {
  const MusicHome({super.key});

  @override
  State<MusicHome> createState() => _MusicHomeState();
}

AssetsAudioPlayer player = AssetsAudioPlayer();
int? playingId;
Songs? currentlyPlaying;

class _MusicHomeState extends State<MusicHome> {
  bool isfavcolor = false;
  bool isrepeat = false;
  bool isshuffle = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isfavcolor = favc.favlist.contains(currentlyPlaying);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: player.builderCurrent(builder: (context, Playing) {
          playingId = int.parse(Playing.audio.audio.metas.id!);

          songfind(playingId!);

          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      )),
                  SizedBox(width: 30.w),
                  SizedBox(
                    height: 250.h,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: QueryArtworkWidget(
                      size: 3000,
                      quality: 100,
                      artworkQuality: FilterQuality.high,
                      keepOldArtwork: true,
                      artworkBorder: const BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100)),
                      artworkFit: BoxFit.cover,
                      id: int.parse(playingId.toString()),
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: Container(
                        decoration: const BoxDecoration(
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
                  text: player.getCurrentAudioTitle,
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
                width: 150.w,
                child: Center(
                  child: Text(
                    player.getCurrentAudioArtist,
                    style: GoogleFonts.robotoSlab(),
                    overflow: TextOverflow.ellipsis,
                  ),
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
                              favc.addfav(currentlyPlaying!);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Song added to favorites'),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              isfavcolor = false;
                              favc.removefav(currentlyPlaying!);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Song removed from favorites'),
                                duration: Duration(seconds: 2),
                              ));
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
                              context: context, song: currentlyPlaying!);
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
                child: player.builderRealtimePlayingInfos(
                    builder: (context, infos) {
                  Duration currentposition = infos.currentPosition;
                  Duration totalduration = infos.duration;
                  return ProgressBar(
                    progress: currentposition,
                    total: totalduration,
                    baseBarColor: Colors.grey,
                    thumbColor: const Color.fromARGB(255, 247, 22, 6),
                    onSeek: (to) {
                      player.seek(to);
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
                            player.setLoopMode(LoopMode.single);
                          } else {
                            isrepeat = false;
                            player.setLoopMode(LoopMode.playlist);
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
                          player.toggleShuffle();
                        });
                      },
                      icon: player.isShuffling.value
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
                // mainAxisSize: MainAxisSize.max,
                children: [
                  IconButton(
                      onPressed: () {
                        player.previous();
                      },
                      icon: const Icon(Icons.skip_previous, size: 35)),
                  PlayerBuilder.isPlaying(
                    player: player,
                    builder: (context, isPlaying) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            isPlaying = !isPlaying;
                            player.playOrPause();
                          });
                        },
                        child: Icon(
                            isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_fill,
                            size: 60),
                      );
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        player.next();
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
