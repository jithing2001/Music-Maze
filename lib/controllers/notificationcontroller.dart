import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer/view/Settings/settings.dart';

class NotificationController extends GetxController {
  RxBool notification = false.obs;

  notificationFunction(value) async {
    notification.value = value;
    Box<bool> notifydb = await Hive.openBox('notification');
    notifydb.add(notification.value);
  }
}
