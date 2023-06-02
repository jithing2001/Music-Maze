import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/Screens/SplashScreen/splashscreen.dart';
import 'package:flutter/services.dart';
import 'package:musicplayer/database/favmodel.dart';
import 'package:musicplayer/database/playlist_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(FavmodelAdapter().typeId)) {
    Hive.registerAdapter(FavmodelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlaylistClassAdapter().typeId)) {
    Hive.registerAdapter(PlaylistClassAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      designSize: const Size(360, 700),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: const Color.fromRGBO(217, 217, 217, 1),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Color.fromRGBO(217, 217, 217, 1))),
          home: const SplashScreen(),
        );
      },
    );
  }
}
