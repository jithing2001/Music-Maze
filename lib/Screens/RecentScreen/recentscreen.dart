import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/listtiledialog.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/Screens/MusicHome/musichome.dart';
import 'package:musicplayer/Screens/favorites.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        title: const Text(
          'Recent Songs',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 25,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          );
        },
        itemCount: recentSongs.value.length,
        itemBuilder: ((context, index) {
          return InkWell(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: InkWell(
                onTap: () {
                  currentplaying.stop();
                  showBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      context: context,
                      builder: (context) {
                        return MiniPlayer(
                            img: 'Assets/Images/thumbimg.jpg',
                            songs: recentSongs.value,
                            index: index,
                            icon1: Icons.skip_previous,
                            icon2: Icons.pause,
                            icon3: Icons.skip_next);
                      });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      color: Colors.white),
                  child: Row(
                    children: [
                      Container(
                        height: 80.h,
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          child: QueryArtworkWidget(
                            size: 3000,
                            quality: 100,
                            artworkQuality: FilterQuality.high,
                            artworkBorder: BorderRadius.circular(10),
                            artworkFit: BoxFit.cover,
                            id: recentSongs.value[index].id!,
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
                      SizedBox(width: 20.w),
                      SizedBox(
                        width: 180.w,
                        child: Text(
                          '${recentSongs.value[index].songname}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Listtiledialogbox(
                                        isfav: favlist.value
                                            .contains(recentSongs.value[index]),
                                        song: recentSongs.value[index]),
                                  );
                                });
                          },
                          icon: const Icon(Icons.more_horiz))
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

ValueNotifier<List<Songs>> recentSongs = ValueNotifier([]);
