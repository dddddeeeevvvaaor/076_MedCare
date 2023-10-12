///mengimpor pustaka dan komponen yang diperlukan untuk mengembangkan aplikasi Flutter.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

///Ini adalah kelas utama yang merupakan StatelessWidget. Kelas ini digunakan untuk membuat tampilan halaman yang akan menampilkan pesan pemberitahuan.
class NotifiedPage extends StatelessWidget{
  ///ini adalah variabel label yang digunakan untuk menyimpan teks pemberitahuan yang akan ditampilkan di halaman.
  final String? label;
  ///Kelas ini memiliki konstruktor yang menerima parameter label yang merupakan teks pemberitahuan yang akan ditampilkan di halaman.
  const NotifiedPage({Key?key,required this.label}):super(key:key);
  @override
  ///Metode ini adalah bagian utama dari widget NotifiedPage. Ini membangun tampilan halaman pemberitahuan dengan menggunakan widget-widget Flutter seperti Scaffold, AppBar, IconButton, Text, dan lainnya. Metode ini juga mengambil warna berdasarkan mode tema saat ini menggunakan Get.isDarkMode.
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode?Colors.grey:Colors.white,
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: Icon(Icons.arrow_back_ios,
          color:Get.isDarkMode?Colors.white:Colors.grey,),
        ),
        title: Text(this.label.toString().split("|")[0],style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:Get.isDarkMode?Colors.white:Colors.grey[400],
          ),
          child:Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(this.label.toString().split("|")[1],style: TextStyle(
                  color: Get.isDarkMode?Colors.black:Colors.white,
                fontSize: 30,
              ),),
            ),
          ) ,
        ),
      ),
    );
  }
}