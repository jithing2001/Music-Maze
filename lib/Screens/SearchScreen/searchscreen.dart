import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/listtiledialog.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/Screens/MusicHome/musichome.dart';
import 'package:musicplayer/Screens/favorites.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  ValueNotifier<List<Songs>> data = ValueNotifier([]);

  TextEditingController _searchController = TextEditingController();

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
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                )),
            title: const Text(
              'Search',
              style: TextStyle(fontSize: 25, color: Colors.black),
            ),
            centerTitle: true,
            elevation: 3),
        body: Column(
          children: [
            Container(
              height: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50, top: 20),
                    child: SizedBox(
                      height: 40.h,
                      width: 250.w,
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              onChanged: (value) => search(value),
                              controller: _searchController,
                              autofocus: true,
                              decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey,
                                  hintText: 'Search here'),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                clearText(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            ValueListenableBuilder(
              valueListenable: data,
              builder: (context, value, child) => Expanded(
                  child: _searchController.text.isEmpty ||
                          _searchController.text.trim().isEmpty
                      ? searchFunc(context)
                      : data.value.isEmpty
                          ? searchEmpty()
                          : searchFound(context)),
            )
          ],
        ));
  }

  clearText(context) {
    if (_searchController.text.isNotEmpty) {
      _searchController.clear();
      data.notifyListeners();
    } else {
      Navigator.of(context).pop();
    }
  }

  Widget searchFunc(BuildContext ctx1) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: allsongs.length,
      itemBuilder: (BuildContext context, index) {
        bool isfav = false;
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
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
                      songs: allsongs,
                      index: index,
                    );
                  });
            },
            child: Container(
              height: 70.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: Row(
                children: [
                  Container(
                    height: 70.h,
                    width: 70.w,
                  
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
                        id: allsongs[index].id!,
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
                  SizedBox(width: 20),
                  SizedBox(
                    width: 200,
                    child: Text(
                      allsongs[index].songname ?? 'unknown',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Listtiledialogbox(
                                  isfav:
                                      favlist.value.contains(allsongs[index]),
                                  song: allsongs[index],
                                ),
                              );
                            });
                      },
                      icon: const Icon(Icons.more_horiz))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget searchEmpty() {
    return const SizedBox(
      child: Center(
        child: Text('Song Not Found'),
      ),
    );
  }

  Widget searchFound(BuildContext ctx1) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const Divider();
      },
      itemCount: data.value.length,
      itemBuilder: (BuildContext context, index) {
        // bool isfav = false;
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
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
                      songs: data.value,
                      index: index,
                    );
                  });
            },
            child: Container(
              height: 70.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30))),
              child: Row(
                children: [
                  Container(
                    height: 70.h,
                    width: 70.w,
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
                        id: data.value[index].id!,
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
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      data.value[index].songname!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: Listtiledialogbox(
                                  isfav:
                                      favlist.value.contains(data.value[index]),
                                  song: data.value[index],
                                ),
                              );
                            });
                      },
                      icon: const Icon(Icons.more_horiz))
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  search(String searchText) {
    data.value = allsongs
        .where((element) => element.songname!
            .toLowerCase()
            .contains(searchText.toLowerCase().trim()))
        .toList();
  }
}
