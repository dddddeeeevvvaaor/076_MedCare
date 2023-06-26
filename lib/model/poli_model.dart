// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PoliModel {
  String? id;
  final String nama;
  final int color;
  PoliModel({
    this.id,
    required this.nama,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'color': color,
    };
  }

  factory PoliModel.fromMap(Map<String, dynamic> map) {
    return PoliModel(
      id: map['id'] != null ? map['id'] as String : null,
      nama: map['nama'] as String,
      color: map['color'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PoliModel.fromJson(String source) => PoliModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
