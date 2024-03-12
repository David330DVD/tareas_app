import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class MyPrefs extends GetxController {

  final box = GetStorage(); // The info is saved to a file named GetStorage.gs

  // Other alternative is
  // final box = GetStorage('FileName'); // FileName will be the name for the data file used
  bool get isDark => box.read('darkmode') ?? false;
  ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  void changeTheme(bool val) => box.write('darkmode', val);

}
