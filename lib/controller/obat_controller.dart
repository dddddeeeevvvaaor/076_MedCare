///mengimpor pustaka dan paket yang diperlukan untuk mengakses dan mengelola data Firebase Firestore. juga mengimpor beberapa pustaka lain yang diperlukan oleh Flutter, seperti dart:async dan package:get/get.dart.
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medcare/model/obat_model.dart';

///ini adalah kelas utama yang bertanggung jawab untuk mengelola data obat. Ini berisi sejumlah metode yang memungkinkan untuk menambahkan, mengambil, menghapus, dan memperbarui data obat dalam Firebase Firestore.
class ObatController extends GetxController {
  ///ini adalah objek CollectionReference yang digunakan untuk mengelola data obat di Firebase Firestore.
  final obatController = FirebaseFirestore.instance.collection("obat");

///ini adalah objek StreamController yang digunakan untuk mengelola stream data obat. Ini digunakan untuk mengirim data obat ke widget yang membutuhkan data tersebut.
  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

///ini adalah getter yang mengembalikan streamController.stream. Ini digunakan untuk mendengarkan perubahan pada koleksi "obat" di Firebase Firestore.
  Stream<List<DocumentSnapshot>>? get stream => streamController.stream;

///ini adalah variabel RxList yang digunakan untuk menyimpan daftar obat yang diambil dari Firebase Firestore.
  var obatList = <ObatModel>[].obs;

  ///ini adalah metode yang digunakan untuk menambahkan data obat baru ke Firebase Firestore. Ini mengambil objek ObatModel sebagai argumen, mengonversinya ke bentuk Map, dan kemudian menambahkannya ke koleksi "obat" dalam database. Kemudian, ia mengambil ID dokumen yang baru ditambahkan dan mengupdate dokumen tersebut dengan ID tersebut.
  Future<void> addObat(ObatModel obModel) async {
    final obat = obModel.toMap();

    final DocumentReference documentReference = await obatController.add(obat);

    final String docId = documentReference.id;

    final ObatModel obatModel = ObatModel(
      id: docId,
      title: obModel.title,
      note: obModel.note,
      isCompleted: obModel.isCompleted,
      date: obModel.date,
      startTime: obModel.startTime,
      endTime: obModel.endTime,
      color: obModel.color,
      remind: obModel.remind,
      repeat: obModel.repeat,
    );
    await documentReference.update(obatModel.toMap());
  }

  ///ini adalah metode yang digunakan untuk mengambil data obat dari koleksi "obat" di Firebase Firestore. Ini mengembalikan daftar dokumen dalam bentuk QuerySnapshot, memasukkan mereka ke dalam streamController, dan juga mengembalikan daftar dokumen tersebut dalam bentuk ObatModel.
  Future<List<DocumentSnapshot>> getObat() async {
    final obat = await obatController.get();
    streamController.add(obat.docs);
    obatList.value =
        obat.docs.map((doc) => ObatModel.fromMap(doc.data())).toList();
    return obat.docs;
  }

//ini adalah metode yang digunakan untuk menghapus data obat berdasarkan ID dokumen. Ini mengambil ID sebagai argumen, menghapus dokumen yang sesuai dari koleksi "obat", dan kemudian memanggil getObat() untuk mengupdate tampilan.
  Future deleteObat(String id) async {
    await obatController.doc(id).delete();
    await getObat();
  }

  ///ini adalah metode yang digunakan untuk menandai obat sebagai selesai berdasarkan ID dokumen. Ini mengambil ID sebagai argumen, mengupdate dokumen yang sesuai dengan status "isCompleted", dan kemudian memanggil getObat() untuk mengupdate tampilan.
  Future markObatCompleted(String id) async {
    await obatController.doc(id).update({'isCompleted': 1});
    await getObat();
  }
}
