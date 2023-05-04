import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/Screens/Playlist/playlistsongs.dart';
import 'package:musicplayer/database/playlist_model.dart';
import 'package:musicplayer/functions/eachplaylist.dart';
import 'package:musicplayer/functions/functions.dart';
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
                  content: Container(
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
                          // maxLength: 15,
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
                      print('-------');
                      print(playlistlist.value.length);
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
                                  setState(() {
                                    playlistdelete(index);
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
