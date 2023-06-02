import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/Screens/Playlist/playlist.dart';
import 'package:musicplayer/functions/eachplaylist.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Playlistsongs extends StatefulWidget {
  EachPlaylist playlistEach;

  Playlistsongs({super.key, required this.playlistEach});

  @override
  State<Playlistsongs> createState() => _PlaylistsongsState();
}

List<String> playlistsong = [];

class _PlaylistsongsState extends State<Playlistsongs> {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          title: Text(
            widget.playlistEach.name,
            style: const TextStyle(fontSize: 25, color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return ScaffoldMessenger(
                          key: scaffoldMessengerKey,
                          child: Scaffold(
                            body: Container(
                              width: double.infinity,
                              color: Colors.white,
                              child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.002,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    return Container(
                                      color: Colors.white,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.08,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                          ),
                                          Container(
                                            height: 45.h,
                                            width: 45.w,
                                            child: QueryArtworkWidget(
                                              size: 3000,
                                              quality: 100,
                                              artworkQuality:
                                                  FilterQuality.high,
                                              artworkBorder:
                                                  BorderRadius.circular(10),
                                              artworkFit: BoxFit.cover,
                                              id: allsongs[index].id!,
                                              type: ArtworkType.AUDIO,
                                              nullArtworkWidget: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                  'Assets/Images/thumbimg.jpg',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.15),
                                          SizedBox(
                                              width: 200,
                                              child: Text(
                                                allsongs[index]
                                                    .songname
                                                    .toString(),
                                                style: const TextStyle(fontSize: 18),
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                          const Spacer(),
                                          IconButton(
                                              onPressed: () {
                                                if (widget.playlistEach.songlist
                                                    .contains(
                                                        allsongs[index])) {
                                                  scaffoldMessengerKey
                                                      .currentState
                                                      ?.showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Song already Contains'),
                                                    duration:
                                                        Duration(seconds: 2),
                                                  ));
                                                } else {
                                                  setState(() {
                                                    widget.playlistEach.songlist
                                                        .add(allsongs[index]);

                                                    playc.playlistSongsAddDB(
                                                        allsongs[index],
                                                        widget
                                                            .playlistEach.name);
                                                  });
                                                }
                                              },
                                              icon: const Icon(Icons
                                                  .arrow_circle_up_outlined))
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: allsongs.length),
                            ),
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.playlist_add,
                  color: Colors.black,
                  size: 30,
                ))
          ],
        ),
        body: widget.playlistEach.songlist.isEmpty
            ? const Center(
                child: Text('Playlist is Empty'),
              )
            : ListView.builder(
                itemCount: widget.playlistEach.songlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        playsong(index, widget.playlistEach.songlist);
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
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                height: 70.h,
                                width: 65.h,
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
                                    id: widget.playlistEach.songlist[index].id!,
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
                                width: 190,
                                child: Text(
                                  widget.playlistEach.songlist[index].songname
                                      .toString(),
                                  style: const TextStyle(fontSize: 21),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.playlistEach.songlist
                                          .removeAt(index);

                                      playc.playlistRemoveDB(allsongs[index],
                                          widget.playlistEach.name);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ))
                            ],
                          )),
                    ),
                  );
                },
              ));
  }
}
