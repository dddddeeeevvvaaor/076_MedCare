///mengimpor semua pustaka dan komponen yang diperlukan untuk digunakan dalam kode. Pada contoh ini, tidak ada pustaka tambahan yang diimpor selain pustaka bawaan Dart.
import 'dart:convert';

///Ini adalah kelas yang digunakan untuk merepresentasikan model data Obat (item obat).
class ObatModel {
  String? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  ///ini adalah konstruktor untuk membuat objek ObatModel. dapat memberikan nilai awal untuk id jika ada atau hanya memberikan nilai wajib yang lain.
  ObatModel({
    this.id,
    required this.title,
    required this.note,
    required this.isCompleted,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.remind,
    required this.repeat,
  });

  ///ini adalah metode yang mengonversi objek ObatModel menjadi sebuah Map (peta) dengan nama properti sebagai kunci dan nilai yang sesuai sebagai nilainya. Ini berguna ketika ingin menyimpan data dalam format yang dapat diakses oleh database atau penyimpanan lokal.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'remind': remind,
      'repeat': repeat,
    };
  }

  ///ini adalah metode factory yang digunakan untuk membuat objek ObatModel dari Map yang diberikan. Ini berguna ketika mengambil data dari database atau penyimpanan lokal dan mengkonversinya menjadi objek ObatModel.
  factory ObatModel.fromMap(Map<String, dynamic> map) {
    return ObatModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] as String,
      note: map['note'] as String,
      isCompleted: map['isCompleted'] as int,
      date: map['date'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      color: map['color'] as int,
      remind: map['remind'] as int,
      repeat: map['repeat'] as String,
    );
  }

  ///ini adalah metode yang mengonversi objek ObatModel menjadi format JSON. Ini berguna ketika perlu mengirimkan data ke server atau menyimpannya dalam format JSON.
  String toJson() => json.encode(toMap());

  ///ini adalah metode factory yang digunakan untuk membuat objek ObatModel dari string JSON. Ini berguna ketika menerima data dalam format JSON dari server atau penyimpanan lokal dan ingin mengonversinya menjadi objek ObatModel.
  factory ObatModel.fromJson(String source) =>
      ObatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
