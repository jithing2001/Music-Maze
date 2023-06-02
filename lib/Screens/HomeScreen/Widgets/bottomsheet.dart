import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/dialogboxbottomsheet.dart';
import 'package:musicplayer/Screens/Playlist/playlist.dart';
import 'package:musicplayer/functions/songs.dart';

showPlaylistModalSheet({required BuildContext context, required Songs song}) {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  return showModalBottomSheet(
      backgroundColor: const Color.fromARGB(0, 194, 28, 28),
      context: context,
      builder: (BuildContext context) {
        return ScaffoldMessenger(
          key: scaffoldMessengerKey,
          child: Scaffold(
            body: 
                 Obx(()=>
                    playc.playlistlist.value.isEmpty
                        ? Container(
                            child: const Center(
                                child: Text(
                              'playlist is empty',
                              style: TextStyle(fontSize: 20),
                            )),
                          )
                        : Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                            ),
                            height: MediaQuery.of(context).size.height * 1,
                            child: Stack(
                              children: [
                                ListView.builder(
                                  itemCount: playc.playlistlist.value.length,
                                  itemBuilder: ((context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 25.0, left: 15, right: 15),
                                      child: InkWell(
                                        onTap: () {
                                          if (playc.playlistlist.value[index].songlist
                                              .contains(song)) {
                                            // scaffoldMessengerKey.currentState!
                                            //     .showSnackBar(const SnackBar(
                                            //   content: Text('song already exist'),
                                            //   duration: Duration(seconds: 2),
                                            // ));
                                            Get.snackbar(
                                                '', 'Song already Contains',
                                                duration:
                                                    const Duration(seconds: 2),
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                colorText: Colors.white,
                                                backgroundColor:
                                                    Colors.grey[900]);
                                          } else {
                                            playc.playlistSongsAddDB(song,
                                                playc.playlistlist.value[index].name);
                                            playc.playlistlist.value[index].songlist
                                                .add(song);
                                            Get.snackbar('', 'Song Added',
                                                duration: const Duration(seconds: 2),
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                colorText: Colors.white,
                                                backgroundColor:
                                                    Colors.grey[900]);
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey),
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.08,
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                              ),
                                              const Icon(
                                                Icons.video_library_outlined,
                                                color: Colors.white,
                                                size: 35,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width: 230.w,
                                                    child: Text(
                                                      playc.playlistlist
                                                          .value[index].name,
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 50.h,
                                    width: double.infinity,
                                    color: Colors.grey,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return  BottomsheetDialog();
                                            });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.playlist_add,
                                            size: 25,
                                          ),
                                          SizedBox(width: 10.w),
                                          const Text(
                                            'Create new Playlist',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                 )
               
          ),
        );
      });
}
