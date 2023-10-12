///mengimpor pustaka dan komponen yang diperlukan untuk mengembangkan aplikasi Flutter. Ini mencakup pustaka seperti 'package:flutter/material.dart', 'package:google_fonts/google_fonts.dart', dan 'package:medcare/model/rumahsakit_model.dart'. Pustaka-pustaka ini digunakan untuk mengatur UI, teks, dan model yang digunakan dalam tampilan RumahSakitTile.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcare/model/rumahsakit_model.dart';
import 'package:medcare/theme.dart';

///Ini adalah kelas utama yang merupakan StatelessWidget. Kelas ini digunakan untuk membuat widget yang menampilkan detail rumah sakit.
class RumahSakitTile extends StatelessWidget {
  ///ini adalah variabel rumahSakitModel yang digunakan untuk menyimpan objek RumahSakitModel.
  final RumahSakitModel? rumahSakitModel;

  ///Konstruktor ini menerima parameter rumahSakitModel yang merupakan instance dari RumahSakitModel.
  RumahSakitTile(this.rumahSakitModel);

  ///Metode ini adalah bagian utama dari widget RumahSakitTile. Ini membangun tampilan satu tile rumah sakit dengan menggunakan widget Flutter seperti Container, Text, Row, Icon, dan lainnya.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(rumahSakitModel?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rumahSakitModel?.poli ?? "",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${rumahSakitModel!.startTime} - ${rumahSakitModel!.endTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  rumahSakitModel?.note ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              rumahSakitModel!.isCompleted == 1 ? "COMPLETED" : "Rumah Sakit",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  ///Metode ini adalah metode pribadi yang digunakan untuk mengambil warna latar belakang berdasarkan nomor yang diterima sebagai argumen. Ini mengembalikan warna berdasarkan nilai nomor yang diberikan.
  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }
}
