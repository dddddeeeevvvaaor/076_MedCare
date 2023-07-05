// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  String toJson() => json.encode(toMap());

  factory ObatModel.fromJson(String source) => ObatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
