import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/Screens/Settings/widgets/privacy_policy_dialogue.dart';
import 'package:musicplayer/Screens/Settings/widgets/settingstile.dart';
import 'package:musicplayer/Screens/Settings/widgets/about.dart';
import 'package:share_plus/share_plus.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

late bool notification;

class _SettingsState extends State<Settings> {
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
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          title: const Text(
            'Settings',
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          elevation: 3,
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SettingsTile(
                  title: 'Notification',
                  tileicon: Icons.notifications_active,
                  click: Switch(
                    value: notification,
                    onChanged: (value) {
                      setState(() {
                        notificationFunction(value);
                      });
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.023),
                GestureDetector(
                  onTap: () => Share.share(
                      'https://play.google.com/store/apps/details?id=com.jithin.music_maze'),
                  child: SettingsTile(
                    title: 'Share This App',
                    tileicon: Icons.share,
                    click: const Card(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.023),
                GestureDetector(
                  onTap: () {
                    Get.dialog(PolicyDialog(mdFileName: 'privacy_policy.md'));
                  },
                  child: SettingsTile(
                    title: 'Privacy Policy',
                    tileicon: Icons.privacy_tip,
                    click: const Card(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.023),
                GestureDetector(
                  onTap: () {
                    Get.dialog(
                        PolicyDialog(mdFileName: 'termsandcondition.md'));
                  },
                  child: SettingsTile(
                    title: 'Terms & Condition',
                    tileicon: Icons.event_note,
                    click: const Card(),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.023),
                GestureDetector(
                  onTap: () {
                    // showDialog(
                    //     context: context,
                    //     builder: (BuildContext context) {
                    //       return Dialog(
                    //         shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(30)),
                    //         child: AboutDialogs(
                    //           title: 'About',
                    //           name: 'MUSIC MAZE',
                    //           text1: 'App Designed and Developed\nby JITHIN',
                    //           contact: 'CONTACT',
                    //           mail: 'jithinkyd70@gmail.com',
                    //         ),
                    //       );
                    //     });
                    Get.dialog(AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      content: AboutDialogs(
                        title: 'About',
                        name: 'MUSIC MAZE',
                        text1: 'App Designed and Developed\nby JITHIN',
                        contact: 'CONTACT',
                        mail: 'jithinkyd70@gmail.com',
                      ),
                    ));
                  },
                  child: SettingsTile(
                    title: 'About',
                    tileicon: Icons.info,
                    click: const Card(),
                  ),
                )
              ],
            )));
  }
}

notificationFunction(value) async {
  notification = value;
  Box<bool> notifydb = await Hive.openBox('notification');
  notifydb.add(notification);
}
