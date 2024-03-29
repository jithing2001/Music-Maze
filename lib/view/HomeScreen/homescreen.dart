import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/controllers/homecontroller.dart';
import 'package:musicplayer/view/HomeScreen/Widgets/drawer_widget.dart';
import 'package:musicplayer/view/HomeScreen/Widgets/listtiledialog.dart';
import 'package:musicplayer/view/HomeScreen/Widgets/listtileimage.dart';
import 'package:musicplayer/view/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/view/MusicHome/musichome.dart';
import 'package:musicplayer/view/Playlist/playlist.dart';
import 'package:musicplayer/view/RecentScreen/recentscreen.dart';
import 'package:musicplayer/view/SearchScreen/searchscreen.dart';
import 'package:musicplayer/view/Settings/settings.dart';
import 'package:musicplayer/view/favorites.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';

HomeController homeC = HomeController();

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
                Get.to(SearchScreen());
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
          : GetBuilder(
              init: homeC,
              builder: (controller) {
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
                         
                              return const MiniPlayer();
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
                        homeC.setHomeValue(!homeC.home);
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
                                    Get.dialog(AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      content: Listtiledialogbox(
                                        isfav: favc.favlist
                                            .contains(allsongs[index]),
                                        song: allsongs[index],
                                        key: UniqueKey(),
                                      ),
                                    ));
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
                Get.back();
                Get.to(const RecentScreen());
              },
              child: DrawerListTile(
                  drawericon: Icons.restore,
                  drawertitle: 'RECENT SONGS',
                  iconbgcolor: Colors.brown),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.to(Playlists());
              },
              child: DrawerListTile(
                drawericon: Icons.video_library_outlined,
                drawertitle: 'PLAYLIST',
                iconbgcolor: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.to(Favorites());
              },
              child: DrawerListTile(
                  drawericon: Icons.favorite,
                  drawertitle: 'FAVORITES',
                  iconbgcolor: Colors.red),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.to(const Settings());
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
