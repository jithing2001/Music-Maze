import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsTile extends StatelessWidget {
  String title;
  IconData tileicon;
  Widget? click;

  SettingsTile(
      {super.key, required this.title, required this.tileicon, this.click});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Row(
        children: [
          SizedBox(width: 20.w),
          Icon(
            tileicon,
            size: 30,
          ),
          SizedBox(width: 20.w),
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          click!,
        ],
      ),
    );
  }
}
