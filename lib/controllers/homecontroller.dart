import 'package:get/get.dart';

class HomeController extends GetxController {
  bool home = true;

  setHomeValue(bool value) {
    home = value;
    update();
  }
}
