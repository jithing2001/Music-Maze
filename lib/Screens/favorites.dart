import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/Screens/MusicHome/musichome.dart';
import 'package:musicplayer/Screens/favoritelist.dart';
import 'package:musicplayer/database/favmodel.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<Songs>> favlist = ValueNotifier([]);

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
        ),
        elevation: 3,
        title: Text(
          'Favorites',
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ValueListenableBuilder(
        valueListenable: favlist,
        builder: (BuildContext context, value, Widget? child) =>
            (favlist.value.isEmpty)
                ? Center(child: Text('No Favorites'))
                : favBuilder(),
      ),
    );
  }

  ListView favBuilder() {
    return ListView.builder(
      itemCount: favlist.value.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              if (currentplaying != null) {
                currentplaying.stop();
              }
              showBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  context: context,
                  builder: (context) {
                    return MiniPlayer(
                      img: 'Assets/Images/thumbimg.jpg',
                      icon1: Icons.skip_previous,
                      icon2: Icons.pause,
                      icon3: Icons.skip_next,
                      songs: favlist.value,
                      index: index,
                    );
                  });
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40)),
                  color: Colors.white),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
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
                        id: favlist.value[index].id!,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 210.w,
                        child: Text(
                          '${favlist.value[index].songname}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        removefav(favlist.value[index]);
                        favlist.notifyListeners();

                        print(favlist);
                      },
                      icon: Icon(
                        Icons.favorite,
                        size: 30,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
