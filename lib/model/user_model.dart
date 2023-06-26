// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String name;
  String email;
  String Uid;
  UserModel({
    required this.name,
    required this.email,
    required this.Uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'Uid': Uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      Uid: map['Uid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? name,
    String? email,
    String? Uid,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      Uid: Uid ?? this.Uid,
    );
  }

  @override
  String toString() => 'UserModel(name: $name, email: $email, Uid: $Uid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.Uid == Uid;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ Uid.hashCode;

  static UserModel? fromFirebaseUser(User user) {}
}

//jika ingin memasukkan password nya di database
/*// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String name;
  String email;
  String password;
  String Uid;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.Uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'Uid': Uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      Uid: map['Uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static UserModel? fromFirebaseUser(User user) {}
}
*/