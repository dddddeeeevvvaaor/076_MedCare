///mengimpor pustaka dan komponen yang diperlukan untuk mengatur tampilan dan gaya aplikasi.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

///mendeklarasikan beberapa konstanta dan warna yang akan digunakan dalam aplikasi, seperti bluishClr, yellowClr, pinkClr, white, primaryClr, darkGreyClr, dan dartHeaderClr. Ini adalah warna-warna yang akan digunakan dalam tampilan.
const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
Color dartHeaderClr = Color(0xFF424242);

///mendefinisikan dua tema, yaitu tema cahaya (light) dan tema gelap (dark) untuk aplikasi. Ini mengatur warna latar belakang dan warna primer aplikasi berdasarkan mode tema saat ini.
class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    backgroundColor: darkGreyClr,
    primaryColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}

///mendefinisikan beberapa gaya teks berdasarkan 'Google Fonts' untuk digunakan dalam aplikasi. Ini termasuk subHeadingStyle, HeadingStyle, titleStyle, dan subTitleStyle, yang masing-masing mengatur gaya teks untuk subjudul, judul, judul kecil, dan subjudul kecil sesuai dengan tema saat ini.
TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
  ));
}

TextStyle get HeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  ));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
  ));
}
