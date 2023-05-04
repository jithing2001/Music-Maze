import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musicplayer/functions/songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Listtileimage extends StatelessWidget {
  Songs songs;
  Listtileimage({
    super.key,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), bottomLeft: Radius.circular(40)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: QueryArtworkWidget(
          size: 3000,
          quality: 100,
          artworkQuality: FilterQuality.high,
          artworkBorder: BorderRadius.circular(10),
          artworkFit: BoxFit.cover,
          id: songs.id!,
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
    );
  }
}
