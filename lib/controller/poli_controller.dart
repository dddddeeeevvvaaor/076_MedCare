import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medcare/model/poli_model.dart';

class PoliController {
  final poliController = FirebaseFirestore.instance.collection("poli");

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>>? get stream => streamController.stream;

  Future<void> addPoli(PoliModel plModel) async {
    final poli = plModel.toMap();

    final DocumentReference documentReference = await poliController.add(poli);

    final String docId = documentReference.id;

    final PoliModel poliModel = PoliModel(
      id: docId,
      nama: plModel.nama,
      color: plModel.color,
    );
    await documentReference.update(poliModel.toMap());
  }
}
