import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musicplayer/view/HomeScreen/homescreen.dart';
import 'package:musicplayer/functions/functions.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
   SplashScreen({super.key});

  Functions fun = Functions();

  // @override
  Future fetchcalling() async {
    await Future.delayed(const Duration(seconds: 1));
    await fun.fetchSongs();
    await fun.favFetching();
    await fun.recentFetching();
    await fun.playlistfetching();
    await fun.notificationFetching();

    Get.off(HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchcalling();
    });
    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
      body: Column(
        children: [
          SizedBox(
            height: 80.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              'Assets/Images/24715116-removebg-preview.png',
              height: 320.h,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.028,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.16,
              ),
              Text(
                'MUSIC MAZE',
                style: GoogleFonts.acme(
                    color: const Color.fromARGB(255, 195, 28, 16),
                    fontSize: 50),
              ),
            ],
          ),
          SizedBox(
            height: 90.h,
          ),
          const Text('Version 1.0.0')
        ],
      ),
    );
  }
}
