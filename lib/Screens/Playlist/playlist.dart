import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musicplayer/Screens/Playlist/playlistsongs.dart';
import 'package:musicplayer/functions/eachplaylist.dart';
import 'package:musicplayer/functions/playlistfunction.dart';

class Playlists extends StatefulWidget {
  const Playlists({super.key});

  @override
  State<Playlists> createState() => _PlaylistState();
}

ValueNotifier<List<EachPlaylist>> playlistlist = ValueNotifier([]);

class _PlaylistState extends State<Playlists> {
  final TextEditingController playlistcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
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
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
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
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02),
                        InkWell(
                          onTap: () {
                            setState(() {
                              playlistCreating(playlistcontroller.text);
                              playlistcontroller.text = '';
                            });

                            Navigator.of(context).pop();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
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
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
      body: ValueListenableBuilder(
          valueListenable: playlistlist,
          builder: (BuildContext context, value, Widget? child) {
            return playlistlist.value.isEmpty
                ? Container(
                    child: const Center(
                        child: Text(
                      'playlist is empty',
                      style: TextStyle(fontSize: 20),
                    )),
                  )
                : ListView.builder(
                    itemCount: playlistlist.value.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 10, right: 10),
                        child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Playlistsongs(
                                        playlistEach: playlistlist.value[index],
                                      )));
                            },
                            tileColor: Colors.white,
                            leading: const Icon(
                              Icons.video_library,
                              color: Colors.black,
                              size: 30,
                            ),
                            title: Center(
                              child: Text(
                                playlistlist.value[index].name,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.12,
                                              width: 110.w,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Are you sure you want to delete?',
                                                    style:
                                                        TextStyle(fontSize: 17),
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                              Text(
                                                                'No',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        17),
                                                              ),
                                                            ],
                                                          )),
                                                      SizedBox(
                                                        width: 15.w,
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              playlistdelete(
                                                                  index);
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons.done,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                              Text('yes',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17)),
                                                            ],
                                                          ))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 25,
                                ))),
                      );
                    }));
          }),
    );
  }
}
