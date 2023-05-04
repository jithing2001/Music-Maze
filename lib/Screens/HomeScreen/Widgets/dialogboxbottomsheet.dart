import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:musicplayer/Screens/Playlist/playlist.dart';
import 'package:musicplayer/functions/eachplaylist.dart';
import 'package:musicplayer/functions/playlistfunction.dart';

class BottomsheetDialog extends StatefulWidget {
  const BottomsheetDialog({
    super.key,
  });

  @override
  State<BottomsheetDialog> createState() => _BottomsheetDialogState();
}

class _BottomsheetDialogState extends State<BottomsheetDialog> {
  TextEditingController playlistcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 150.h,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Add new Playlist',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.015,
            ),
            SizedBox(
              width: 200.w,
              height: 60.h,
              child: TextFormField(
                controller: playlistcontroller,
                maxLength: 15,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            InkWell(
              onTap: () {
                setState(() {
                  playlistCreating(playlistcontroller.text);
                  playlistcontroller.text = '';
                });

                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.library_add,
                    color: Colors.black,
                  ),
                  Text(
                    'Add',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
