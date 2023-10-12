///mengimpor semua pustaka dan komponen yang diperlukan untuk digunakan dalam kode. Dalam contoh ini, mengimpor pustaka yang berkaitan dengan Firebase Authentication.
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

///Ini adalah kelas yang digunakan untuk merepresentasikan data pengguna.
class UserModel {
  String name;
  String email;
  String Uid;

  ///ini adalah konstruktor untuk membuat objek UserModel dengan memberikan nilai awal untuk name, email, dan Uid.
  UserModel({
    required this.name,
    required this.email,
    required this.Uid,
  });

  ///ini adalah metode yang mengonversi objek UserModel menjadi sebuah Map (peta) dengan nama, email, dan Uid sebagai kunci dan nilai yang sesuai sebagai nilainya.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'Uid': Uid,
    };
  }

  ///ini adalah metode factory yang digunakan untuk membuat objek UserModel dari Map yang diberikan. Ini digunakan untuk mengkonversi data yang diterima dari Firebase menjadi objek UserModel.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      Uid: map['Uid'] ?? '',
    );
  }

  ///ini adalah metode yang mengonversi objek UserModel menjadi format JSON.
  String toJson() => json.encode(toMap());

  ///ini adalah metode factory yang digunakan untuk membuat objek UserModel dari string JSON. Ini memungkinkan untuk mengkonversi data yang diterima dari sumber eksternal (seperti API) menjadi objek UserModel.
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  ///ini adalah metode yang digunakan untuk membuat salinan objek UserModel dengan kemungkinan pembaruan pada properti name, email, dan Uid. Hal ini berguna untuk menghasilkan objek baru dengan perubahan tertentu.
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

  ///ini adalah metode yang mengembalikan representasi string dari objek UserModel. Ini berguna untuk debug dan log.
  @override
  String toString() => 'UserModel(name: $name, email: $email, Uid: $Uid)';

  ///ini adalah operator yang digunakan untuk membandingkan dua objek UserModel. Hal ini membandingkan nilai properti name, email, dan Uid dari kedua objek.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.Uid == Uid;
  }

  ///ini adalah metode statis yang mungkin digunakan untuk membuat objek UserModel dari objek Firebase User. Ini dapat berguna saat ingin mengonversi data pengguna yang diperoleh melalui Firebase Authentication ke dalam objek UserModel.
  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ Uid.hashCode;

  static UserModel? fromFirebaseUser(User user) {}
}