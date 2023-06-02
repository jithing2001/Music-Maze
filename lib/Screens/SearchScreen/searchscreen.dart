import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/listtiledialog.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/Screens/favorites.dart';
import 'package:musicplayer/controllers/searchcontroller.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  // ValueNotifier<List<Songs>> data = ValueNotifier([]);
  SearchControllers searchc = Get.put(SearchControllers());

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
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
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 40.h,
                    width: 270.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: TextFormField(
                            onChanged: (value) => searchc.search(value),
                            controller: _searchController,
                            autofocus: true,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.grey,
                                hintText: 'Search here'),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        InkWell(
                          onTap: () {
                            clearText(context);
                          },
                          child: const Icon(
                            Icons.cancel_rounded,
                            size: 45,
                          ),
                        )
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
          GetBuilder<SearchControllers>(
            init: searchc,
            builder: (controller) {
              return Expanded(
                  child: _searchController.text.isEmpty ||
                          _searchController.text.trim().isEmpty
                      ? searchFunc(context)
                      : searchc.data.isEmpty
                          ? searchEmpty()
                          : searchFound(context));
            }
          ),
        ],
      ),
    );
  }

  // Widget hello(List data) {
  //   if (data.isEmpty) {
  //     return Text('E');
  //   } else {
  //     return Text('Ne');
  //   }
  // }

  clearText(context) {
    if (_searchController.text.isNotEmpty) {
      _searchController.clear();
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
              playsong(index, allsongs);
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
                      borderRadius: const BorderRadius.only(
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
                  const SizedBox(width: 20),
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
                        Get.dialog(AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          content: Listtiledialogbox(
                              isfav:
                                  favc.favlist.value.contains(allsongs[index]),
                              song: allsongs[index]),
                        ));
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
      itemCount: searchc.data.length,
      itemBuilder: (BuildContext context, index) {
        // bool isfav = false;
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: InkWell(
            onTap: () {
              playsong(index, searchc.data);
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
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30)),
                      child: QueryArtworkWidget(
                        size: 3000,
                        quality: 100,
                        artworkQuality: FilterQuality.high,
                        artworkBorder: BorderRadius.circular(10),
                        artworkFit: BoxFit.cover,
                        id: searchc.data[index].id!,
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
                  const SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      searchc.data[index].songname!,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Get.dialog(AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          content: Listtiledialogbox(
                              isfav: favc.favlist.value
                                  .contains(searchc.data.value[index]),
                              song: searchc.data.value[index]),
                        ));
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

  // search(String searchText) {
  //   data.value = allsongs
  //       .where((element) => element.songname!
  //           .toLowerCase()
  //           .contains(searchText.toLowerCase().trim()))
  //       .toList();
  // }
}
