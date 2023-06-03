import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/view/Playlist/playlistsongs.dart';
import 'package:musicplayer/controllers/playlistcontroller.dart';

PlaylistController playc = PlaylistController();

class Playlists extends StatelessWidget {
  Playlists({super.key});

  final TextEditingController playlistcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 30,
                color: Colors.black,
              )),
          elevation: 3,
          title: const Text(
            'PLAYLIST',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.dialog(AlertDialog(
              backgroundColor: Colors.grey[800],
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.161,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Create a playlist',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    TextFormField(
                      controller: playlistcontroller,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    InkWell(
                      onTap: () {
                        playc.playlistCreating(playlistcontroller.text);
                        playlistcontroller.text = '';

                        Get.back();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.playlist_add,
                            color: Colors.white,
                          ),
                          Text(
                            'Create',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.black,
        ),
        body: Obx(
          () => playc.playlistlist.isEmpty
              ? Container(
                  child: const Center(
                      child: Text(
                    'playlist is empty',
                    style: TextStyle(fontSize: 20),
                  )),
                )
              : ListView.builder(
                  itemCount: playc.playlistlist.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 15, left: 10, right: 10),
                      child: ListTile(
                          onTap: () {
                            Get.to(Playlistsongs(
                              playlistEach: playc.playlistlist[index],
                            ));
                          },
                          tileColor: Colors.white,
                          leading: const Icon(
                            Icons.video_library,
                            color: Colors.black,
                            size: 30,
                          ),
                          title: Center(
                            child: Text(
                              playc.playlistlist[index].name,
                              style: const TextStyle(fontSize: 25),
                            ),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                Get.dialog(Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.12,
                                      width: 110.w,
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Are you sure you want to delete?',
                                            style: TextStyle(fontSize: 17),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      ),
                                                      Text(
                                                        'No',
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      ),
                                                    ],
                                                  )),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    playc.playlistdelete(index);
                                                    Get.back();
                                                  },
                                                  child: const Row(
                                                    children: [
                                                      Icon(
                                                        Icons.done,
                                                        color: Colors.green,
                                                      ),
                                                      Text('yes',
                                                          style: TextStyle(
                                                              fontSize: 17)),
                                                    ],
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 25,
                              ))),
                    );
                  })),
        ));
  }
}
