import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medcare/model/obat_model.dart';

class ObatController extends GetxController
{
  final obatController = FirebaseFirestore.instance.collection("obat");
  
  final StreamController<List<DocumentSnapshot>> streamController = 
  StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>>? get stream => streamController.stream;

  var obatList = <ObatModel>[].obs;

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

    Future getObat() async {
    final obat = await obatController.get();
    streamController.add(obat.docs);
    return obat.docs;
  }
}