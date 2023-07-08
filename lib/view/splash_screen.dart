import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medcare/view/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 6),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login(),));
    });
  }

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