import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medcare/controller/poli_controller.dart';
import 'package:medcare/model/rumahsakit_model.dart';

class RumahSakitController extends GetxController {
  var poliController = PoliController();
    final rumahSakitController = FirebaseFirestore.instance.collection("rumahsakit");

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>>? get stream => streamController.stream;

  var rumahsakitList = <RumahSakitModel>[].obs;

  Future<void> addRumahSakit(RumahSakitModel rsModel) async {
    final rumahsakit = rsModel.toMap();

    final DocumentReference documentReference = await rumahSakitController.add(rumahsakit);

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

  Future<List> getPolis() async {
    var polis = await poliController.getPoli();
    return polis;
  }

  Future<List<DocumentSnapshot>> getRumahSakit() async {
    final rumahsakit = await rumahSakitController.get();
    streamController.add(rumahsakit.docs);
    rumahsakitList.value = rumahsakit.docs.map((doc) => RumahSakitModel.fromMap(doc.data())).toList();
    return rumahsakit.docs;
  }

  Future deleteRumahSakit(String id) async {
    await rumahSakitController.doc(id).delete();
    await getRumahSakit();
  }

  Future markRumahSakitCompleted(String id) async {
    await rumahSakitController.doc(id).update({'isCompleted': 1});
    await getRumahSakit();
  }
}
