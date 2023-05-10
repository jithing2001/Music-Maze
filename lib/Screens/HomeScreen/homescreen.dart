import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/drawer_widget.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/listtiledialog.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/listtileimage.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/Screens/MusicHome/musichome.dart';
import 'package:musicplayer/Screens/Playlist/playlist.dart';
import 'package:musicplayer/Screens/RecentScreen/recentscreen.dart';
import 'package:musicplayer/Screens/SearchScreen/searchscreen.dart';
import 'package:musicplayer/Screens/Settings/settings.dart';
import 'package:musicplayer/Screens/favorites.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<bool> home = ValueNotifier(true);

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  final _audioQuery = OnAudioQuery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'All Songs',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 30,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchScreen()));
              },
              icon: const Icon(
                Icons.manage_search,
                color: Colors.black,
                size: 30,
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          )
        ],
      ),
      body: allsongs.isEmpty
          ? const Center(
              child: Text('No songs found'),
            )
          : ValueListenableBuilder(
              valueListenable: home,
              builder: (context, value, child) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    if (currentlyPlaying != null) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        showBottomSheet(
                            enableDrag: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            context: context,
                            builder: (context) {
                              return MiniPlayer(
                                 );
                            });
                      });
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    );
                  },
                  itemCount: allsongs.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        playsong(index, allsongs);
                        home.notifyListeners();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Listtileimage(
                                songs: allsongs[index],
                              ),
                              SizedBox(width: 30.w),
                              SizedBox(
                                width: 150.w,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(allsongs[index].songname.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis),
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.01),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 100.w,
                                          child: Text(
                                            allsongs[index].artist.toString(),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
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
                                                    .contains(allsongs[index]),
                                                song: allsongs[index]),
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.more_horiz))
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                );
              }),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'MUSIC MAZE',
                style: GoogleFonts.acme(
                    color: const Color.fromARGB(255, 195, 28, 16),
                    fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RecentScreen(),
                ));
              },
              child: DrawerListTile(
                  drawericon: Icons.restore,
                  drawertitle: 'RECENT SONGS',
                  iconbgcolor: Colors.brown),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Playlists(),
                ));
              },
              child: DrawerListTile(
                drawericon: Icons.video_library_outlined,
                drawertitle: 'PLAYLIST',
                iconbgcolor: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Favorites()));
              },
              child: DrawerListTile(
                  drawericon: Icons.favorite,
                  drawertitle: 'FAVORITES',
                  iconbgcolor: Colors.red),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Settings()));
              },
              child: DrawerListTile(
                  drawericon: Icons.settings,
                  drawertitle: 'SETTINGS',
                  iconbgcolor: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
