///mengimpor semua pustaka yang diperlukan untuk digunakan dalam kode. Pada contoh ini, tidak ada pustaka yang diimpor selain pustaka bawaan dari Flutter.
import 'dart:convert';

///Ini adalah kelas yang digunakan untuk merepresentasikan model data Rumah Sakit.
class RumahSakitModel {
  ///ini adalah variabel instance yang digunakan untuk menyimpan informasi tentang data Rumah Sakit.
  String? id;
  String? poli;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  ///ini adalah konstruktor untuk membuat objek RumahSakitModel dengan memberikan nilai awal untuk semua properti yang mungkin.
  RumahSakitModel({
    this.id,
    this.poli,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
  });

  ///ini adalah metode yang mengonversi objek RumahSakitModel menjadi sebuah Map (peta) dengan nama properti sebagai kunci dan nilai yang sesuai sebagai nilainya. Ini berguna ketika ingin menyimpan data dalam format yang dapat diakses oleh database atau penyimpanan lokal.
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'poli': poli,
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

  ///ini adalah metode factory yang digunakan untuk membuat objek RumahSakitModel dari Map yang diberikan. Ini berguna ketika ingin mengambil data dari database atau penyimpanan lokal dan mengkonversinya menjadi objek RumahSakitModel.
  factory RumahSakitModel.fromMap(Map<String, dynamic> map) {
    return RumahSakitModel(
      id: map['id'] != null ? map['id'] as String : null,
      poli: map['poli'] != null ? map['poli'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
      isCompleted:
          map['isCompleted'] != null ? map['isCompleted'] as int : null,
      date: map['date'] != null ? map['date'] as String : null,
      startTime: map['startTime'] != null ? map['startTime'] as String : null,
      endTime: map['endTime'] != null ? map['endTime'] as String : null,
      color: map['color'] != null ? map['color'] as int : null,
      remind: map['remind'] != null ? map['remind'] as int : null,
      repeat: map['repeat'] != null ? map['repeat'] as String : null,
    );
  }

  ///ini adalah metode yang mengonversi objek RumahSakitModel menjadi format JSON. Ini berguna ketika perlu mengirimkan data ke server atau menyimpannya dalam format JSON.
  String toJson() => json.encode(toMap());

  ///ini adalah metode factory yang digunakan untuk membuat objek RumahSakitModel dari string JSON. Ini berguna ketika menerima data dalam format JSON dari server atau penyimpanan lokal dan ingin mengonversinya menjadi objek RumahSakitModel.
  factory RumahSakitModel.fromJson(String source) =>
      RumahSakitModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
