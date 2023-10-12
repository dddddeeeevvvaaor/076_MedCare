///mengimpor pustaka dan komponen yang diperlukan untuk mengembangkan aplikasi Flutter. Ini termasuk beberapa pustaka seperti package:flutter/material.dart, package:google_fonts/google_fonts.dart, dan package:medcare/model/obat_model.dart. Pustaka-pustaka ini digunakan untuk mengatur tampilan UI dan mengambil data dari model.
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medcare/model/obat_model.dart';
import 'package:medcare/theme.dart';

///Ini adalah kelas utama yang merupakan StatelessWidget. Kelas ini digunakan untuk membangun widget yang menampilkan informasi tentang obat.
class ObatTile extends StatelessWidget {
  ///ini adalah variabel obatModel yang digunakan untuk menyimpan objek ObatModel.
  final ObatModel? obatModel;

  ///Konstruktor menerima objek ObatModel sebagai parameter yang akan digunakan untuk menampilkan informasi obat.
  ObatTile(this.obatModel);

  ///Metode ini adalah bagian utama dari widget ObatTile. Ini membangun tampilan satu tile obat dengan menggunakan widget Flutter seperti Container, Text, Row, Icon, dan lainnya. Di bawah ini adalah beberapa elemen penting dalam tile obat:
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
          color: _getBGClr(obatModel?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  obatModel?.title ?? "",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
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
                      "${obatModel!.startTime} - ${obatModel!.endTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  obatModel?.note ?? "",
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
              obatModel!.isCompleted == 1 ? "COMPLETED" : "OBAT",
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
