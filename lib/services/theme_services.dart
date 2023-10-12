///mengimpor pustaka dan komponen yang diperlukan untuk mengelola tema aplikasi dalam kode Flutter. Ini termasuk import untuk Flutter Material library (flutter/material.dart), GetX state management (get/get.dart), dan GetStorage untuk menyimpan pengaturan tema aplikasi.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

///Ini adalah kelas yang bertanggung jawab untuk mengelola tema aplikasi dalam aplikasi.
class ThemeService{
  final _box = GetStorage();
  final _key = 'isDarkMode';
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);
  bool _loadThemeFromBox() => _box.read(_key) ?? false;
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme(){
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}