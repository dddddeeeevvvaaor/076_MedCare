///mengimpor beberapa pustaka dan komponen yang diperlukan. Ini mencakup dart:async, cloud_firestore.dart yang merupakan pustaka Firebase Cloud Firestore, serta beberapa pustaka lain yang digunakan dalam proyek ini. Ini penting untuk memastikan bahwa semua pustaka yang diperlukan telah diimpor sebelum digunakan dalam kode.
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medcare/controller/poli_controller.dart';
import 'package:medcare/model/rumahsakit_model.dart';

///Ini adalah kelas utama yang bertanggung jawab untuk mengelola data Rumah Sakit. Ini adalah sebuah GetxController, yang digunakan dengan GetX, state management library untuk Flutter.
class RumahSakitController extends GetxController {
  ///ini adalah objek PoliController, yang mungkin digunakan untuk mengelola data Poli.
  var poliController = PoliController();
  ///ini adalah objek CollectionReference yang digunakan untuk mengelola data Rumah Sakit di Cloud Firestore.
  final rumahSakitController =
      FirebaseFirestore.instance.collection("rumahsakit");

///ini adalah objek StreamController yang digunakan untuk mengelola stream data Rumah Sakit. Ini digunakan untuk mengirim data Rumah Sakit ke widget yang membutuhkan data tersebut.
  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

///ini adalah getter yang mengembalikan streamController.stream. Ini digunakan untuk mendengarkan perubahan pada koleksi "rumahsakit" di Cloud Firestore.
  Stream<List<DocumentSnapshot>>? get stream => streamController.stream;

///ini adalah variabel RxList yang digunakan untuk menyimpan daftar Rumah Sakit yang diambil dari Cloud Firestore.
  var rumahsakitList = <RumahSakitModel>[].obs;

  ///ini adalah metode yang digunakan untuk menambahkan data Rumah Sakit baru ke Cloud Firestore. Ini mengambil objek RumahSakitModel sebagai argumen, mengonversinya ke bentuk Map, dan kemudian menambahkannya ke koleksi "rumahsakit" dalam database. Kemudian, ia mengambil ID dokumen yang baru ditambahkan dan mengupdate dokumen tersebut dengan ID tersebut.
  Future<void> addRumahSakit(RumahSakitModel rsModel) async {
    final rumahsakit = rsModel.toMap();

    final DocumentReference documentReference =
        await rumahSakitController.add(rumahsakit);

    final String docId = documentReference.id;

    final RumahSakitModel rumahsakitModel = RumahSakitModel(
      id: docId,
      poli: rsModel.poli,
      title: rsModel.title,
      note: rsModel.note,
      isCompleted: rsModel.isCompleted,
      date: rsModel.date,
      startTime: rsModel.startTime,
      endTime: rsModel.endTime,
      color: rsModel.color,
      remind: rsModel.remind,
      repeat: rsModel.repeat,
    );
    await documentReference.update(rumahsakitModel.toMap());
  }

  ///ini adalah metode yang digunakan untuk mengambil data Poli (mungkin departemen atau poliklinik) dari PoliController. Ini mengembalikan daftar poli.
  Future<List> getPolis() async {
    var polis = await poliController.getPoli();
    return polis;
  }

  ///ini adalah metode yang digunakan untuk mengambil data Rumah Sakit dari koleksi "rumahsakit" di Cloud Firestore. Ini mengembalikan daftar dokumen dalam bentuk DocumentSnapshot, memasukkan mereka ke dalam streamController, dan juga mengonversi data tersebut ke dalam RumahSakitModel dan menyimpannya dalam rumahsakitList.
  Future<List<DocumentSnapshot>> getRumahSakit() async {
    final rumahsakit = await rumahSakitController.get();
    streamController.add(rumahsakit.docs);
    rumahsakitList.value = rumahsakit.docs
        .map((doc) => RumahSakitModel.fromMap(doc.data()))
        .toList();
    return rumahsakit.docs;
  }

  ///ini adalah metode yang digunakan untuk menghapus data Rumah Sakit berdasarkan ID dokumen. Ini mengambil ID sebagai argumen, menghapus dokumen yang sesuai dari koleksi "rumahsakit", dan kemudian memanggil getRumahSakit() untuk mengupdate tampilan.
  Future deleteRumahSakit(String id) async {
    await rumahSakitController.doc(id).delete();
    await getRumahSakit();
  }

  ///ini adalah metode yang digunakan untuk menandai data Rumah Sakit sebagai selesai berdasarkan ID dokumen. Ini mengambil ID sebagai argumen, mengupdate dokumen yang sesuai dengan status "isCompleted" menjadi 1 (mungkin menandakan bahwa proses tertentu telah selesai), dan kemudian memanggil getRumahSakit() untuk mengupdate tampilan.
  Future markRumahSakitCompleted(String id) async {
    await rumahSakitController.doc(id).update({'isCompleted': 1});
    await getRumahSakit();
  }
}
