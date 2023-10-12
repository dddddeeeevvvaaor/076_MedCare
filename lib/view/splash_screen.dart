///mengimpor pustaka dan komponen yang diperlukan untuk mengembangkan halaman SplashScreen. Ini mencakup pustaka Flutter seperti dart:async, package:get/get.dart, package:flutter/cupertino.dart, package:flutter/material.dart, dan package:lottie/lottie.dart.
import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medcare/view/login.dart';

///Ini adalah kelas utama yang merupakan StatefulWidget. Kelas ini digunakan untuk membuat tampilan halaman SplashScreen dan mengelola logika navigasi ke halaman Login setelah beberapa detik.
class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ///Metode initState digunakan untuk menginisialisasi halaman dan memulai timer yang akan mengarahkan pengguna ke halaman Login setelah 6 detik.
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 6),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(),));
    });
  }

///Metode build adalah bagian utama dari widget SplashScreen. Ini membangun tampilan halaman SplashScreen dengan menggunakan widget-widget Flutter seperti Scaffold, Container, dan Lottie.asset.
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Get.isDarkMode?Colors.black:Colors.cyan,
      body: Center(
        child: Container(
          child: Lottie.asset(
            'animations/lottie.json',
          ),
        ),
      ),
    );
  }
}