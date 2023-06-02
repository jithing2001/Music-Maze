import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/listtiledialog.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/Screens/favorites.dart';
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
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
                size: 25,
              )),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Obx(
          () => ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.005,
              );
            },
            itemCount: recentc.recentSongs.length,
            itemBuilder: ((context, index) {
              return InkWell(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: InkWell(
                    onTap: () {
                      playsong(index, recentc.recentSongs.value);
                      showBottomSheet(
                          enableDrag: false,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          context: context,
                          builder: (context) {
                            return const MiniPlayer();
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
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              child: QueryArtworkWidget(
                                size: 3000,
                                quality: 100,
                                artworkQuality: FilterQuality.high,
                                artworkBorder: BorderRadius.circular(10),
                                artworkFit: BoxFit.cover,
                                id: recentc.recentSongs[index].id!,
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
                              '${recentc.recentSongs[index].songname}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Get.dialog(AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  content: Listtiledialogbox(
                                      isfav: favc.favlist.value.contains(
                                          recentc.recentSongs.value[index]),
                                      song: recentc.recentSongs.value[index]),
                                ));
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
        ));
  }
}

// ValueNotifier<List<Songs>> recentSongs = ValueNotifier([]);
