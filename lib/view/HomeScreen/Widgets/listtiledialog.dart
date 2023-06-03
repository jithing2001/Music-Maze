import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/controllers/faviconcontroller.dart';
import 'package:musicplayer/view/HomeScreen/Widgets/bottomsheet.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:musicplayer/view/favorites.dart';

FavIconController favi = FavIconController();

class Listtiledialogbox extends StatelessWidget {
  Listtiledialogbox({super.key, required this.isfav, required this.song});

  bool isfav;
  Songs song;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      width: 110.w,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.back();

                showPlaylistModalSheet(
                  context: context,
                  song: song,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.playlist_add)),
                  const Text(
                    'Add to Playlist',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                favi.iconFunction(song, context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Icon(
                      Icons.favorite,
                      color: favc.favlist.contains(song)
                          ? Colors.red
                          : Colors.black,
                    ),
                  ),
                  Obx(
                    () => Text(
                      favc.favlist.contains(song)
                          ? 'Remove from Favorites'
                          : 'Add to Favorites',
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
