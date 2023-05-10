import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musicplayer/Screens/HomeScreen/Widgets/bottomsheet.dart';
import 'package:musicplayer/Screens/favoritelist.dart';
import 'package:musicplayer/Screens/favorites.dart';
import 'package:musicplayer/functions/songs.dart';

class Listtiledialogbox extends StatefulWidget {
  Listtiledialogbox({super.key, required this.isfav, required this.song});

  bool isfav;
  Songs song;
  @override
  State<Listtiledialogbox> createState() => _ListtiledialogboxState();
}

class _ListtiledialogboxState extends State<Listtiledialogbox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.16,
      width: 110.w,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();

                showPlaylistModalSheet(
                  context: context,
                  song: widget.song,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.playlist_add)),
                  const Text(
                    'Add to Playlist',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                setState(() {
                  if (widget.isfav == true) {
                    widget.isfav = false;
                    removefav(widget.song);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Song removed from favorites'),
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    widget.isfav = true;

                    addfav(widget.song);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Song added to favorites'),
                      duration: Duration(seconds: 2),
                    ));
                  }
                  favlist.notifyListeners();
                });
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite,
                    color: widget.isfav ? Colors.red : Colors.black,
                  ),
                  Text(
                    widget.isfav ? 'Remove from Favorites' : 'Add to Favorites',
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
