///mengimpor pustaka dan komponen yang diperlukan untuk mengembangkan aplikasi Flutter.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medcare/services/theme_services.dart';
import 'package:medcare/theme.dart';
import 'package:medcare/view/splash_screen.dart';

///ini adalah fungsi utama yang akan dijalankan pertama kali ketika aplikasi dijalankan. Ini memanggil WidgetsFlutterBinding.ensureInitialized () untuk menginisialisasi Flutter Engine dan Firebase.initializeApp () untuk menginisialisasi Firebase.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

///Ini adalah kelas utama yang merupakan StatelessWidget. Kelas ini adalah root dari aplikasi.
class MyApp extends StatelessWidget {
  ///Kelas ini tidak memiliki konstruktor yang menerima parameter tambahan.
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override

  ///Metode ini adalah bagian utama dari widget MyApp. Ini membangun tampilan utama aplikasi menggunakan widget GetMaterialApp. Di bawah ini adalah beberapa atribut penting yang digunakan dalam GetMaterialApp:
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: SplashScreen(),
    );
  }
}
