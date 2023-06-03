import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:musicplayer/view/HomeScreen/Widgets/listtiledialog.dart';
import 'package:musicplayer/view/HomeScreen/Widgets/miniplayer.dart';
import 'package:musicplayer/controllers/favcontroller.dart';
import 'package:on_audio_query/on_audio_query.dart';

FavController favc = Get.put(FavController());

class Favorites extends StatelessWidget {
  Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.black,
          ),
          elevation: 3,
          title: const Text(
            'Favorites',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Obx(() => (favc.favlist.isEmpty)
            ? const Center(child: Text('No Favorites'))
            : favBuilder()));
  }

  ListView favBuilder() {
    return ListView.builder(
      itemCount: favc.favlist.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              playsong(index, favc.favlist);
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
                      topLeft: Radius.circular(40),
                      bottomLeft: Radius.circular(40)),
                  color: Colors.white),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.2,
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
                        id: favc.favlist[index].id!,
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
                    width: 20.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 190.w,
                        child: Text(
                          '${favc.favlist[index].songname}',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        favc.removefav(favc.favlist[index]);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Song removed from favorites'),
                          duration: Duration(seconds: 2),
                        ));
                        favi.isfav.value = false;
                      },
                      icon: const Icon(
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
