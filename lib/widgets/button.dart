///mengimpor pustaka dan komponen yang diperlukan untuk mengembangkan widget MyButton. Ini mencakup pustaka Flutter seperti package:flutter/cupertino.dart, package:flutter/material.dart, dan package:medcare/theme.dart.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medcare/theme.dart';

///Ini adalah kelas utama yang merupakan StatelessWidget. Kelas ini digunakan untuk membuat tombol kustom dengan tampilan yang sesuai.
class MyButton extends StatelessWidget {
  ///ini adalah variabel label yang digunakan untuk menyimpan teks yang akan ditampilkan di tombol.
  final String label;
  ///ini adalah variabel onPressed yang digunakan untuk menyimpan fungsi yang akan dipanggil saat tombol ditekan.
  final Function()? onPressed;
  ///ini adalah konstruktor yang menerima parameter label yang merupakan teks yang akan ditampilkan di tombol dan onPressed yang merupakan fungsi yang akan dipanggil saat tombol ditekan.
  const MyButton({Key? key, required this.label, required this.onPressed})
      : super(key: key);

  ///Metode ini adalah bagian utama dari widget MyButton. Ini membangun tampilan tombol dengan tampilan berikut:
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 110,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: primaryClr),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
