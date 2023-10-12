///mengimpor pustaka yang diperlukan, seperti dart:async dan cloud_firestore.dart. Ini penting untuk memastikan bahwa semua pustaka yang diperlukan telah diimpor sebelum digunakan dalam kode.
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medcare/model/poli_model.dart';

///Ini adalah kelas utama yang bertanggung jawab untuk mengelola data Poli (mungkin departemen atau poliklinik). Ini berisi sejumlah metode yang memungkinkan untuk menambahkan, mengambil, menghapus, dan memperbarui data Poli dalam Cloud Firestore.
class PoliController {
  ///ini adalah objek CollectionReference yang digunakan untuk mengelola data Poli di Cloud Firestore.
  final poliController = FirebaseFirestore.instance.collection("poli");

///ini adalah objek StreamController yang digunakan untuk mengelola stream data Poli. Ini digunakan untuk mengirim data Poli ke widget yang membutuhkan data tersebut.
  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

///ini adalah getter yang mengembalikan streamController.stream. Ini digunakan untuk mendengarkan perubahan pada koleksi "poli" di Cloud Firestore.
  Stream<List<DocumentSnapshot>>? get stream => streamController.stream;

///ini adalah metode yang digunakan untuk menambahkan data Poli baru ke Cloud Firestore. Ini mengambil objek PoliModel sebagai argumen, mengonversinya ke bentuk Map, dan kemudian menambahkannya ke koleksi "poli" dalam database. Kemudian, ia mengambil ID dokumen yang baru ditambahkan dan mengupdate dokumen tersebut dengan ID tersebut.
  Future<void> addPoli(PoliModel plModel) async {
    final poli = plModel.toMap();

    final DocumentReference documentReference = await poliController.add(poli);

    final String docId = documentReference.id;

    final PoliModel poliModel = PoliModel(
      id: docId,
      nama: plModel.nama,
    );
    await documentReference.update(poliModel.toMap());
  }

///ini adalah metode yang digunakan untuk mengambil data Poli dari koleksi "poli" di Cloud Firestore. Ini mengembalikan daftar dokumen dalam bentuk QuerySnapshot, memasukkan mereka ke dalam streamController, dan juga mengembalikan daftar dokumen tersebut.
  Future getPoli() async {
    final poli = await poliController.get();
    streamController.add(poli.docs);
    return poli.docs;
  }

///ini adalah metode yang digunakan untuk menghapus data Poli berdasarkan ID dokumen. Ini mengambil ID sebagai argumen, menghapus dokumen yang sesuai dari koleksi "poli", dan kemudian memanggil getPoli() untuk mengupdate tampilan.
  Future<void> deletePoli(String id) async {
    await poliController.doc(id).delete();
    await getPoli();
  }

///ini adalah metode yang digunakan untuk memperbarui data Poli berdasarkan ID dokumen. Ini mengambil objek PoliModel yang telah diperbarui sebagai argumen, dan mengupdate dokumen yang sesuai dengan data yang baru.
  Future<void> updatePoli(PoliModel plModel) async {
    await poliController.doc(plModel.id).update(plModel.toMap());
  }
}
