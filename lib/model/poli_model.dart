///mengimpor semua pustaka dan komponen yang diperlukan untuk digunakan dalam kode. Pada contoh ini, tidak ada pustaka tambahan yang diimpor selain pustaka bawaan Dart.
import 'dart:convert';

///Ini adalah kelas yang digunakan untuk merepresentasikan model data Poli (unit pelayanan kesehatan).
class PoliModel {
  String? id;
  final String nama;

  ///ini adalah konstruktor untuk membuat objek PoliModel. dapat memberikan nilai awal untuk id jika ada atau hanya memberikan nama.
  PoliModel({
    this.id,
    required this.nama,
  });

  /// ini adalah metode yang mengonversi objek PoliModel menjadi sebuah Map (peta) dengan nama properti sebagai kunci dan nilai yang sesuai sebagai nilainya. Ini berguna ketika ingin menyimpan data dalam format yang dapat diakses oleh database atau penyimpanan lokal.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
    };
  }

  ///ini adalah metode factory yang digunakan untuk membuat objek PoliModel dari Map yang diberikan. Ini berguna ketika mengambil data dari database atau penyimpanan lokal dan mengkonversinya menjadi objek PoliModel.
  factory PoliModel.fromMap(Map<String, dynamic> map) {
    return PoliModel(
      id: map['id'] != null ? map['id'] as String : null,
      nama: map['nama'] as String,
    );
  }

  ///ini adalah metode yang mengonversi objek PoliModel menjadi format JSON. Ini berguna ketika perlu mengirimkan data ke server atau menyimpannya dalam format JSON.
  String toJson() => json.encode(toMap());

  ///ini  adalah metode factory yang digunakan untuk membuat objek PoliModel dari string JSON. Ini berguna ketika menerima data dalam format JSON dari server atau penyimpanan lokal dan ingin mengonversinya menjadi objek PoliModel.
  factory PoliModel.fromJson(String source) =>
      PoliModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
